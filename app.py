from flask import Flask, render_template, request, redirect, url_for, flash
import pymysql.cursors
import base64
import tempfile
import base64
import os
import subprocess
import speech_recognition as sr
from pydub import AudioSegment
from pysentimiento import create_analyzer
import requests


app = Flask(__name__)
analyzer = create_analyzer(task="sentiment", lang="es")

def generate_image(prompt):
    API_KEY= os.environ["OPENAI_KEY"]
    headers = {
        "Authorization": f"Bearer {API_KEY}"
    }
    data = {
        "prompt": prompt,
        "num_images": 1,
        "size": "256x256",
        "response_format": "url"
    }
    response = requests.post("https://api.openai.com/v1/images/generations", headers=headers, json=data)

    if response.status_code == 200:
        result = response.json()
        return result["data"][0]["url"]
    else:
        print("Error generating image:", response.text)
        return None

def get_db_connection():
    connection = pymysql.connect(
        host='localhost',
        user='root',
        password='12345678',
        database='tec_courses',
        cursorclass=pymysql.cursors.DictCursor
    )
    return connection

@app.route('/')
def index():

    connection = get_db_connection()
    with connection.cursor() as cursor:
        cursor.execute("SELECT * FROM courses")
        courses = cursor.fetchall()

    course_sentiments = []
    course_images = []

    for course in courses:
        sentiment_counts = get_sentiment_counts(course["id"])
        # Generate the course image
        if not course["image_url"]:
            image_url = generate_image(course["name"])
            with connection.cursor() as cursor:
                cursor.execute("UPDATE courses SET image_url=%s WHERE id=%s", (image_url, course["id"]))
                connection.commit()
        else:
            image_url = course["image_url"]
        course_images.append(image_url)
       

        total_comments = sum(sentiment_counts.values())
        if total_comments > 0:
            percentage_positive = (sentiment_counts["positive"] / total_comments) * 100
            percentage_negative = (sentiment_counts["negative"] / total_comments) * 100
            percentage_neutral = (sentiment_counts["neutral"] / total_comments) * 100
        else:
            percentage_positive = 0
            percentage_negative = 0
            percentage_neutral = 0

        sentiment_dict = {
            "positive": percentage_positive,
            "negative": percentage_negative,
            "neutral": percentage_neutral
        }

        course_sentiments.append(sentiment_dict)

    

    return render_template('index.html', courses=courses, course_sentiments=course_sentiments, course_images=course_images, zip=zip)

@app.route('/course/<int:course_id>', methods=['GET', 'POST'])
def course(course_id):
    connection = get_db_connection()

    if request.method == 'POST' and 'generate_image' in request.form:
        with connection.cursor() as cursor:
            cursor.execute("SELECT name FROM courses WHERE id=%s", (course_id,))
            course = cursor.fetchone()
        image_url = generate_image(course["name"])
        with connection.cursor() as cursor:
            cursor.execute("UPDATE courses SET image_url=%s WHERE id=%s", (image_url, course_id))
            connection.commit()
        return redirect(url_for('course', course_id=course_id))

    if request.method == 'POST' :
        audio_file = request.files.get("audio_file")
        recorded_audio_blob = request.form.get("recorded_audio_blob")
        text_comment = request.form["comment"]

        if not text_comment and not audio_file and not recorded_audio_blob:
            flash("Por favor, ingrese un comentario de texto, suba un archivo de audio o grabe su comentario.")
            return redirect(url_for("course", course_id=course_id))

        if audio_file or recorded_audio_blob:
            recognizer = sr.Recognizer()

            if audio_file:
                audio_path = audio_file.filename
                audio_file.save(audio_path)
                audio_format = audio_path.split(".")[-1]
            elif recorded_audio_blob:
                audio_data = base64.b64decode(recorded_audio_blob.split(',')[1])
                audio_format = 'webm'
                with tempfile.NamedTemporaryFile(delete=False, suffix=f'.{audio_format}') as f:
                    f.write(audio_data)
                    audio_path = f.name

            if audio_format == 'webm':
                converted_path = audio_path.replace('.webm', '.wav')
                command = f"ffmpeg -i {audio_path} {converted_path}"
                subprocess.call(command, shell=True)
                audio_path = converted_path
                audio_format = 'wav'
                    
            audio = AudioSegment.from_file(audio_path, format=audio_format)
            audio.export("audio.wav", format="wav")

            with sr.AudioFile("audio.wav") as audio_file:
                audio_data = recognizer.record(audio_file)
                try:
                    comment = recognizer.recognize_google(audio_data, language="es-ES")
                except sr.UnknownValueError:
                    flash("No se pudo entender el audio. Intente nuevamente.")
                    return redirect(url_for("course", course_id=course_id))
                except sr.RequestError as e:
                    flash(f"Error en el servicio de reconocimiento de voz: {e}")
                    return redirect(url_for("course", course_id=course_id))

            os.remove(audio_path)
            os.remove("audio.wav")
        else:
            comment = text_comment

        sentiment = analyzer.predict(comment).output.lower()

        with connection.cursor() as cursor:
            cursor.execute("INSERT INTO comments (course_id, content, sentiment) VALUES (%s, %s, %s)", (course_id, comment, sentiment))
            connection.commit()

        return redirect(url_for('course', course_id=course_id))

    with connection.cursor() as cursor:
        cursor.execute("SELECT * FROM courses WHERE id=%s", (course_id,))
        course = cursor.fetchone()
        cursor.execute("SELECT * FROM comments WHERE course_id=%s", (course_id,))
        comments = cursor.fetchall()

    return render_template('course.html', course=course, comments=comments, flash=flash)

@app.route('/generate_image/<int:course_id>', methods=['GET'])
def generate_image_route(course_id):
    connection = get_db_connection()
    with connection.cursor() as cursor:
        cursor.execute("SELECT name FROM courses WHERE id=%s", (course_id,))
        course = cursor.fetchone()
    image_url = generate_image(course["name"])
    with connection.cursor() as cursor:
        cursor.execute("UPDATE courses SET image_url=%s WHERE id=%s", (image_url, course_id))
        connection.commit()
    return redirect(url_for('course', course_id=course_id))


def get_sentiment_counts(course_id):
    connection = get_db_connection()
    with connection.cursor() as cursor:
        cursor.execute(
            "SELECT sentiment, COUNT(*) as count FROM comments WHERE course_id = %s GROUP BY sentiment",
            (course_id,)
        )
        sentiment_counts = cursor.fetchall()

    sentiment_counts_dict = {"positive": 0, "negative": 0, "neutral": 0}
    for row in sentiment_counts:
        sentiment_label = row["sentiment"].lower()
        if sentiment_label in sentiment_counts_dict:
            sentiment_counts_dict[sentiment_label] += row["count"]
        elif sentiment_label == 'pos':
            sentiment_counts_dict['positive'] += row["count"]
        elif sentiment_label == 'neu':
            sentiment_counts_dict['neutral'] += row["count"]
        elif sentiment_label == 'neg':
            sentiment_counts_dict['negative'] += row["count"]

    return sentiment_counts_dict


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5001)
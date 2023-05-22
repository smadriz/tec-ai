CREATE DATABASE tec_courses;

USE tec_courses;

CREATE TABLE courses (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE comments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    course_id INT NOT NULL,
    content TEXT NOT NULL,
    sentiment VARCHAR(255) NOT NULL,
    FOREIGN KEY (course_id) REFERENCES courses(id)
);

INSERT INTO courses (name) VALUES ('Inteligencia Artificial');
INSERT INTO courses (name) VALUES ('Sistemas Operativos');
INSERT INTO courses (name) VALUES ('Compiladores e Intérpretes');
INSERT INTO courses (name) VALUES ('Bases de Datos I');
INSERT INTO courses (name) VALUES ('Bases de Datos II');
INSERT INTO courses (name) VALUES ('Diseño de Software');
INSERT INTO courses (name) VALUES ('Administración de Proyectos');
INSERT INTO courses (name) VALUES ('Requerimientos de Software');
INSERT INTO courses (name) VALUES ('Computación y Sociedad');

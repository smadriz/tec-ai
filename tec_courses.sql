-- MySQL dump 10.13  Distrib 8.0.33, for macos13 (x86_64)
--
-- Host: localhost    Database: tec_courses
-- ------------------------------------------------------
-- Server version	8.0.33

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `comments`
--

DROP TABLE IF EXISTS `comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `course_id` int NOT NULL,
  `content` text NOT NULL,
  `sentiment` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `course_id` (`course_id`),
  CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comments`
--

LOCK TABLES `comments` WRITE;
/*!40000 ALTER TABLE `comments` DISABLE KEYS */;
INSERT INTO `comments` VALUES (1,1,'excelente curso y profesor','pos'),(2,2,'Me fascina el curso','pos'),(3,2,'Me fascina el curso','pos'),(4,2,'','neu'),(5,2,'','neu'),(6,2,'','neu'),(7,2,'muy mal curso','neg'),(8,3,'Me fascina el curso','pos'),(9,4,'','neu'),(10,4,'','neu'),(11,5,'','neu'),(12,6,'Me fascina el curso','pos'),(13,6,'Hola','neu'),(14,7,'','neu'),(15,7,'Me fascina el curso','pos'),(16,7,'Me fascina el curso','pos'),(17,8,'Me fascina el curso','pos'),(18,8,'Me fascina el curso','pos'),(19,8,'Hola hola','neu'),(20,8,'este curso Me parece muy difícil la verdad Considero que el profesor no fue tan bueno no me gustó tanto el curso','neg'),(21,9,'Me fascina el curso','pos'),(22,9,'me gustó mucho este curso','pos'),(23,5,'mal curso','neg'),(24,5,'Me fascina el curso','pos'),(25,5,'me encanta este curso','pos'),(26,1,'No me gusta el curso','neg'),(27,1,'masomenos este curso','neu'),(28,1,'Me fascina el curso','pos'),(29,2,'me gusta mucho este curso','pos'),(30,1,'Me fascina este curso lo único que no me gustó fue que las clases eran demasiado largas','neg');
/*!40000 ALTER TABLE `comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `courses`
--

DROP TABLE IF EXISTS `courses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `courses` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `image_url` varchar(2048) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courses`
--

LOCK TABLES `courses` WRITE;
/*!40000 ALTER TABLE `courses` DISABLE KEYS */;
INSERT INTO `courses` VALUES (1,'Inteligencia Artificial','https://oaidalleapiprodscus.blob.core.windows.net/private/org-LeBmex2oHdNiIFpqbuHy0X1p/user-8n4ZNZF7Az23huNZ390q5Ezo/img-YsmKrs2stQHgbYv23ZUzsfs1.png?st=2023-05-21T21%3A24%3A14Z&se=2023-05-21T23%3A24%3A14Z&sp=r&sv=2021-08-06&sr=b&rscd=inline&rsct=image/png&skoid=6aaadede-4fb3-4698-a8f6-684d7786b067&sktid=a48cca56-e6da-484e-a814-9c849652bcb3&skt=2023-05-21T09%3A09%3A25Z&ske=2023-05-22T09%3A09%3A25Z&sks=b&skv=2021-08-06&sig=9P4udq5vscBMr3QLg45Owk3/se6gHflSnlLrQ5%2BQFTg%3D'),(2,'Sistemas Operativos','https://oaidalleapiprodscus.blob.core.windows.net/private/org-LeBmex2oHdNiIFpqbuHy0X1p/user-8n4ZNZF7Az23huNZ390q5Ezo/img-uGYE0mrMX1Kt56eLsW1RPhTd.png?st=2023-05-21T21%3A20%3A28Z&se=2023-05-21T23%3A20%3A28Z&sp=r&sv=2021-08-06&sr=b&rscd=inline&rsct=image/png&skoid=6aaadede-4fb3-4698-a8f6-684d7786b067&sktid=a48cca56-e6da-484e-a814-9c849652bcb3&skt=2023-05-21T07%3A29%3A54Z&ske=2023-05-22T07%3A29%3A54Z&sks=b&skv=2021-08-06&sig=PPfjh6y0qYT%2B4zsn3kaiReBcewedc6LX/8wp5hbm5Fs%3D'),(3,'Compiladores e Intérpretes','https://oaidalleapiprodscus.blob.core.windows.net/private/org-LeBmex2oHdNiIFpqbuHy0X1p/user-8n4ZNZF7Az23huNZ390q5Ezo/img-dhAUB46n7v2hP5mkRhU9SVcf.png?st=2023-05-21T21%3A20%3A48Z&se=2023-05-21T23%3A20%3A48Z&sp=r&sv=2021-08-06&sr=b&rscd=inline&rsct=image/png&skoid=6aaadede-4fb3-4698-a8f6-684d7786b067&sktid=a48cca56-e6da-484e-a814-9c849652bcb3&skt=2023-05-21T10%3A52%3A53Z&ske=2023-05-22T10%3A52%3A53Z&sks=b&skv=2021-08-06&sig=InjJef1w795m4Vy4D6azlYTygNyQNI4hNmMqQkrFT6I%3D'),(4,'Bases de Datos I','https://oaidalleapiprodscus.blob.core.windows.net/private/org-LeBmex2oHdNiIFpqbuHy0X1p/user-8n4ZNZF7Az23huNZ390q5Ezo/img-RR5nM37nswehEyvV5rb0W3Bk.png?st=2023-05-21T21%3A21%3A15Z&se=2023-05-21T23%3A21%3A15Z&sp=r&sv=2021-08-06&sr=b&rscd=inline&rsct=image/png&skoid=6aaadede-4fb3-4698-a8f6-684d7786b067&sktid=a48cca56-e6da-484e-a814-9c849652bcb3&skt=2023-05-21T16%3A03%3A29Z&ske=2023-05-22T16%3A03%3A29Z&sks=b&skv=2021-08-06&sig=VuhUPGfn7/OlALiYkosE6lQ8oUByJMSZ4wN2E1X9QBU%3D'),(5,'Bases de Datos II','https://oaidalleapiprodscus.blob.core.windows.net/private/org-LeBmex2oHdNiIFpqbuHy0X1p/user-8n4ZNZF7Az23huNZ390q5Ezo/img-vCU1GKcdRuzr5dy25r2wFQ7u.png?st=2023-05-21T21%3A21%3A26Z&se=2023-05-21T23%3A21%3A26Z&sp=r&sv=2021-08-06&sr=b&rscd=inline&rsct=image/png&skoid=6aaadede-4fb3-4698-a8f6-684d7786b067&sktid=a48cca56-e6da-484e-a814-9c849652bcb3&skt=2023-05-21T18%3A53%3A31Z&ske=2023-05-22T18%3A53%3A31Z&sks=b&skv=2021-08-06&sig=tffETBq70NIKMgZPDxIxjXVpU6%2BsReYzzuTKcV1yXiA%3D'),(6,'Diseño de Software','https://oaidalleapiprodscus.blob.core.windows.net/private/org-LeBmex2oHdNiIFpqbuHy0X1p/user-8n4ZNZF7Az23huNZ390q5Ezo/img-v9bEXNZa22jZAF49UL794BEs.png?st=2023-05-21T21%3A21%3A20Z&se=2023-05-21T23%3A21%3A20Z&sp=r&sv=2021-08-06&sr=b&rscd=inline&rsct=image/png&skoid=6aaadede-4fb3-4698-a8f6-684d7786b067&sktid=a48cca56-e6da-484e-a814-9c849652bcb3&skt=2023-05-20T22%3A55%3A17Z&ske=2023-05-21T22%3A55%3A17Z&sks=b&skv=2021-08-06&sig=4yJP0tp65nu6xLLsvO8rheEbbxt4Q2gfvpbnOiFCZYE%3D'),(7,'Administración de Proyectos','https://oaidalleapiprodscus.blob.core.windows.net/private/org-LeBmex2oHdNiIFpqbuHy0X1p/user-8n4ZNZF7Az23huNZ390q5Ezo/img-WKC1XJ3CHg6vea4N8uFxxCO0.png?st=2023-05-21T21%3A21%3A31Z&se=2023-05-21T23%3A21%3A31Z&sp=r&sv=2021-08-06&sr=b&rscd=inline&rsct=image/png&skoid=6aaadede-4fb3-4698-a8f6-684d7786b067&sktid=a48cca56-e6da-484e-a814-9c849652bcb3&skt=2023-05-21T21%3A42%3A18Z&ske=2023-05-22T21%3A42%3A18Z&sks=b&skv=2021-08-06&sig=XXanqQL/h4L/YGbb8L5cbQT1Gq2/BRvER3EpoN/mewY%3D'),(8,'Requerimientos de Software','https://oaidalleapiprodscus.blob.core.windows.net/private/org-LeBmex2oHdNiIFpqbuHy0X1p/user-8n4ZNZF7Az23huNZ390q5Ezo/img-1PBxIDAYwiwKeOQvm8Fm7W8R.png?st=2023-05-21T21%3A21%3A34Z&se=2023-05-21T23%3A21%3A34Z&sp=r&sv=2021-08-06&sr=b&rscd=inline&rsct=image/png&skoid=6aaadede-4fb3-4698-a8f6-684d7786b067&sktid=a48cca56-e6da-484e-a814-9c849652bcb3&skt=2023-05-21T20%3A59%3A38Z&ske=2023-05-22T20%3A59%3A38Z&sks=b&skv=2021-08-06&sig=q2Auefgpkkx3X4a2IdpMZzkjaT7OtSF7uf/Yk/cKPiE%3D'),(9,'Computación y Sociedad','https://oaidalleapiprodscus.blob.core.windows.net/private/org-LeBmex2oHdNiIFpqbuHy0X1p/user-8n4ZNZF7Az23huNZ390q5Ezo/img-zDDOY9ZpwDOmp67T3TyPbZWV.png?st=2023-05-21T21%3A21%3A38Z&se=2023-05-21T23%3A21%3A38Z&sp=r&sv=2021-08-06&sr=b&rscd=inline&rsct=image/png&skoid=6aaadede-4fb3-4698-a8f6-684d7786b067&sktid=a48cca56-e6da-484e-a814-9c849652bcb3&skt=2023-05-21T02%3A49%3A40Z&ske=2023-05-22T02%3A49%3A40Z&sks=b&skv=2021-08-06&sig=gjsMHvAaG7MK9VZyTVl1VCSNIGq5SrfmYCj493OANKQ%3D');
/*!40000 ALTER TABLE `courses` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-05-21 22:31:34

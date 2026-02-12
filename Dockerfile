# Étape 1 : build avec Maven + JDK 21
FROM maven:3.9.4-jdk-21 AS build

# Crée un dossier de travail
WORKDIR /app

# Copie le pom.xml et le dossier src
COPY pom.xml .
COPY src ./src

# Compile et package le projet sans exécuter les tests
RUN mvn clean package -DskipTests

# Étape 2 : runtime léger avec OpenJDK 21
FROM eclipse-temurin:21-jdk-alpine

WORKDIR /app

# Copie le jar généré depuis l'étape de build
COPY --from=build /app/target/*.jar app.jar

# Commande pour lancer l'application
ENTRYPOINT ["java", "-jar", "app.jar"]

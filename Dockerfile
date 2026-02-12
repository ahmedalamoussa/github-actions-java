# Étape 1 : Build le projet
FROM maven:3.9.9-eclipse-temurin-17 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# Étape 2 : runtime léger
FROM eclipse-temurin:21-jdk-jammy
WORKDIR /app
COPY --from=build /app/target/calculator-1.0-SNAPSHOT.jar app.jar
ENTRYPOINT ["java","-jar","app.jar"]

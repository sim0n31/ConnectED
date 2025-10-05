# --- Build (Maven + Java 17)
FROM maven:3.9.6-eclipse-temurin-17 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
# Construye y deja el jar con un nombre predecible
RUN mvn -DskipTests package && \
    ls -l /app/target && \
    cp /app/target/*.jar /app/app.jar

# --- Runtime (JRE 17)
FROM eclipse-temurin:17-jre-jammy
WORKDIR /app
# Copiamos el jar con nombre fijo
COPY --from=build /app/app.jar /app/app.jar

ENV PORT=8080
EXPOSE 8080

ENTRYPOINT ["java","-jar","/app/app.jar"]

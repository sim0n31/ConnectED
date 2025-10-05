# --- Etapa de build (igual que antes)
FROM maven:3.9.6-eclipse-temurin-17 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn -DskipTests package

# --- Runtime
FROM eclipse-temurin:17-jre-jammy
WORKDIR /app

# Copiamos el/los JAR(es) sin renombrar
COPY --from=build /app/target/*.jar /app/

ENV PORT=8080
EXPOSE 8080

# Ejecuta cualquiera que haya: *.jar
ENTRYPOINT ["sh","-c","exec java -jar /app/*.jar"]

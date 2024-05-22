FROM openjdk:17-alpine
COPY src/main/resources/application.properties /app/application.properties
COPY build/libs/*.jar app.jar
EXPOSE 8081
ENTRYPOINT ["java", "-jar", "app.jar", "--spring.config.location=/app/application.properties"]

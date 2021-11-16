FROM maven:3.6-jdk-11 as builder

WORKDIR /app
COPY pom.xml .
COPY src ./src

RUN mvn package -DskipTests

FROM adoptopenjdk/openjdk11:alpine-slim

COPY --from=builder /app/target/spring-boot-web-0.0.2-SNAPSHOT.jar /app.jar


CMD ["java", "-Xmx1024m", "-Djava.security.egd=file:/dev/./urandom",  "-jar", "/app.jar"]
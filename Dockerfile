FROM maven:3.6.3-openjdk-11-slim as BUILDER
ARG VERSION=1.0.0-SNAPSHOT
WORKDIR /build/
COPY pom.xml /build/
COPY src /build/src/

RUN mvn clean package
COPY target/Specialization-${VERSION}.jar target/application.jar

FROM openjdk:11.0.13-jre-slim
WORKDIR /app/

COPY --from=BUILDER /build/target/application.jar /app/
CMD java -jar /app/application.jar

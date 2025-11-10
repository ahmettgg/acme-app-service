# runtime image - small and secure
FROM amazoncorretto:21-alpine-jdk AS runtime

WORKDIR /app
COPY target/*.jar /app/app.jar

# optionally set JVM options via env var
ENV JAVA_OPTS=""

ENTRYPOINT ["sh", "-c", "exec java $JAVA_OPTS -jar /app/app.jar"]

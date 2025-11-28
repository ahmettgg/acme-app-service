##### BUILD Stage #####
FROM maven:3.9.9-amazoncorretto-21-debian AS build
# Add current directory to /src in the image
# Accept the Maven profile (dev/prod) as a build argument
# <-- default: dev
ARG MAVEN_PROFILE=dev
# Accept CodeArtifact token passed from GitHub Actions
ARG CODEARTIFACT_AUTH_TOKEN
# Make the token available to Maven inside the container
ENV CODEARTIFACT_AUTH_TOKEN=${CODEARTIFACT_AUTH_TOKEN}
# Copy the Maven settings.xml containing the CodeArtifact server credentials
COPY settings.xml /root/.m2/settings.xml
# Add current directory to /src in the image
ADD . /src
# Set the working directory to /src
WORKDIR /src
# Build the application
RUN mvn -B -s /root/.m2/settings.xml clean package -DskipTests -P${MAVEN_PROFILE}

# runtime image - small and secure
FROM amazoncorretto:21-alpine-jdk AS runtime

# WORKDIR /app
# COPY target/*.jar /app/app.jar
COPY --from=build /src/target/*.jar /app/

# optionally set JVM options via env vara
ENV JAVA_OPTS=""

ENTRYPOINT ["sh", "-c", "exec java $JAVA_OPTS -jar /app/app.jar"]

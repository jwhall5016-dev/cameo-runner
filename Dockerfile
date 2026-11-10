# Base image
FROM x11docker/mate

#Install Dependencies
RUN apt-get update
RUN apt-get -y install openjdk-11-jdk
RUN apt-get -y install xvfb

# Set work space
WORKDIR /opt/app

# Set args
ARG SERVICE_JAR_FILE=cameo-rest-api/target/cameo-rest-api-0.0.1-SNAPSHOT.jar
ARG RUNNER_JAR_FILE=cameo-runner/target/cameo-runner-0.0.1-SNAPSHOT.jar

# Copy executables to image
COPY ${SERVICE_JAR_FILE} ./target/cameo-rest-api-0.0.1-SNAPSHOT.jar
COPY ${RUNNER_JAR_FILE} ./target/cameo-runner-0.0.1-SNAPSHOT.jar
COPY ./nomagic ./nomagic


# Run the jar file in a GUI wrapper (XVFB) to support Magic Draw UI dependencies since cameo is looking for a UI to reference
# Also specifically add nomagic jar library folders and cameo runner jar to the webservice classpath since they can't easily be added as maven dependencies
CMD xvfb-run java -cp "target/cameo-rest-api-0.0.1-SNAPSHOT.jar:nomagic/lib/*:nomagic/lib/graphics/*:target/cameo-runner-0.0.1-SNAPSHOT.jar" -Dloader.main=io.cameorestservice.cameo.CameoRestAPIApp org.springframework.boot.loader.PropertiesLauncher

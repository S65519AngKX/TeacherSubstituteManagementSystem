# Use an official OpenJDK base image
FROM openjdk:17-slim

# Install Apache Ant
RUN apt-get update && \
    apt-get install -y ant && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy the project files to the container
COPY . .

# Build the Java project using Ant
RUN ant

FROM tomcat:9.0-jdk17
RUN rm -rf /usr/local/tomcat/webapps/*
COPY --from=build /app/build/S65519_TeacherSubstituteManagementSystem.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8080
CMD ["catalina.sh", "run"]
FROM openjdk:17 AS builder
RUN apt-get update && apt-get install -y ant
WORKDIR /app
COPY . .
RUN mkdir -p /usr/share/tomcat && \
    ant -Dj2ee.server.home=/usr/share/tomcat

FROM tomcat:9.0-jdk17
RUN rm -rf /usr/local/tomcat/webapps/*
COPY --from=builder /app/dist/S65519_TeacherSubstituteManagementSystem.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8080
CMD ["catalina.sh", "run"]

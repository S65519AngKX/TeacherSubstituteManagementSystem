# Stage 1: Build with Ant
FROM ant:1.10.9-jdk17 AS builder
WORKDIR /app
COPY . .
RUN mkdir -p /usr/share/tomcat && \
    ant -Dj2ee.server.home=/usr/share/tomcat

# Stage 2: Deploy to Tomcat
FROM tomcat:9.0-jdk17
RUN rm -rf /usr/local/tomcat/webapps/*
COPY --from=builder /app/dist/S65519_TeacherSubstituteManagementSystem.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8080
CMD ["catalina.sh", "run"]

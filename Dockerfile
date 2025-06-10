FROM openjdk:17-slim AS build
RUN apt-get update && apt-get install -y ant
WORKDIR /app
COPY . .
RUN ant

FROM tomcat:9.0-jdk17
RUN rm -rf /usr/local/tomcat/webapps/*
COPY --from=build /app/dist/S65519_TeacherSubstituteManagementSystem.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8080
CMD ["catalina.sh", "run"]

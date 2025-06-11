FROM tomcat:9.0-jdk17-openjdk-slim

RUN rm -rf /usr/local/tomcat/webapps/*

# Copy your WAR file (renamed as ROOT.war)
COPY dist/S65519_TeacherSubstituteManagementSystem.war /usr/local/tomcat/webapps/ROOT.war

CMD ["bash", "-c", "sed -i \"s/port=\"8080\"/port=\\\"$PORT\\\"/\" /usr/local/tomcat/conf/server.xml && catalina.sh run"]

FROM tomcat:9.0-jdk17

# Remove default webapps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy your Ant-built WAR file to Tomcat webapps and rename to ROOT.war
COPY dist/S65519_TeacherSubstituteManagementSystem.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080

CMD ["catalina.sh", "run"]

# Start with a base image that has Java and WildFly.
# Use an official WildFly image from JBoss.
FROM jboss/wildfly:latest # Or a specific version like jboss/wildfly:29.0.1.Final-jdk17

# Set up a special place for WildFly inside the transport box.
ENV WILDFLY_HOME=/opt/jboss/wildfly

# This is the CORRECTED line for your .war file.
COPY dist/S65519_TeacherSubstituteManagementSystem.war $WILDFLY_HOME/standalone/deployments/S65519_TeacherSubstituteManagementSystem.war

# Tell the "transport box" that your app will be talking on port 8080.
EXPOSE 8080

# This command starts the WildFly server when the "transport box" runs.
CMD ["/opt/jboss/wildfly/bin/standalone.sh", "-b", "0.0.0.0"]
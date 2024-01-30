# Use the official Tomcat image as the base image
FROM tomcat:latest

# Copy your WAR file into the webapps directory
ADD ./target/EMS-0.0.1-SNAPSHOT.war /usr/local/tomcat/webapps/

# Expose the default Tomcat port
EXPOSE 8090

# Start Tomcat
CMD ["catalina.sh", "run"]

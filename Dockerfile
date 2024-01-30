FROM tomcat:latest
LABEL maintainer="chaitanya"
RUN mv /usr/local/tomcat/webapps /usr/local/tomcat/webapps2
RUN mv /usr/local/tomcat/webapps.dist /usr/local/tomcat/webapps
ADD ./target/*.war /usr/local/tomcat/webapps/
EXPOSE 8090
CMD ["catalina.sh", "run"]

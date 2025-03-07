FROM tomcat:9-jre9
MAINTAINER "achuthmpalankar@gmail.com"
COPY ./target/pal.war /usr/local/tomcat/webapps 

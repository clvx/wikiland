#Inherits from centos:centos6, if it doesn't exist pulls the image.
FROM centos:centos6
MAINTAINER Clvx <michael.ibarra@ubicando.pe>

#Executes commands
RUN yum -y update; yum clean all
RUN yum -y install httpd
RUN echo "This is our new Apache Test Site" >> /var/www/html/index.html

#The container will listen on the specified network ports at runtime.
#Docker uses this information to interconnect containers using links and
#to determine which ports to expose to the host when using the -P flag.
EXPOSE 80

RUN echo "/sbin/service httpd start" >> /root/.bashrc



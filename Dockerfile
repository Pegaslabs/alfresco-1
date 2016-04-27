# gui81/alfresco

FROM centos:centos7
MAINTAINER Florian JUDITH <florian.judith.b@gmail.com>
#MAINTAINER Ralf Sippl <ralf.sippl@gmail.com>

# install some necessary/desired RPMs and get updates
RUN yum update -y
RUN yum install -y epel-release
RUN yum install -y \
    fontconfig \
    libSM \
    libICE \
    libXrender \
    libXext \
    cups-libs \
    supervisor \
    vim \
    nano \
    xmlstartlet
RUN yum clean all

COPY assets/install_alfresco.sh /tmp/install_alfresco.sh
RUN /tmp/install_alfresco.sh

COPY assets/install_mysql_connector.sh /tmp/install_mysql_connector.sh
RUN /tmp/install_mysql_connector.sh

# this is for LDAP configuration
RUN mkdir -p /alfresco/tomcat/shared/classes/alfresco/extension/subsystems/Authentication/ldap/ldap1/
RUN mkdir -p /alfresco/tomcat/shared/classes/alfresco/extension/subsystems/Authentication/ldap-ad/ldap1/
COPY assets/ldap-authentication.properties /alfresco/tomcat/shared/classes/alfresco/extension/subsystems/Authentication/ldap/ldap1/ldap-authentication.properties
COPY assets/ldap-ad-authentication.properties /alfresco/tomcat/shared/classes/alfresco/extension/subsystems/Authentication/ldap-ad/ldap1/ldap-ad-authentication.properties

COPY assets/init.sh /alfresco/init.sh
COPY assets/supervisord.conf /etc/supervisord.conf

RUN mkdir -p /alfresco/tomcat/webapps/ROOT
COPY assets/index.jsp /alfresco/tomcat/webapps/ROOT/


VOLUME /alfresco/tomcat/logs
VOLUME /alfresco/alf_data

EXPOSE 21 137 138 139 445 7070 8080
CMD /usr/bin/supervisord -n

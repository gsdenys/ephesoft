#gsdenys/ephesoft

FROM centos:centos7
MAINTAINER Denys G. Santos <gsdenys@gmail.com>

RUN yum update -y && \
	yum install -y \
					cups-libs \
                    dbus-glib \
                    fontconfig \
                    hostname \
                    libICE \
                    libSM \
                    libXext \
                    libXinerama \
                    libXrender \
                    supervisor \
                    wget \
                   	unzip \
                   	patch && \
	yum clean all

# install oracle java
COPY assets/install_java.sh /tmp/install_java.sh
RUN /tmp/install_java.sh && \
    rm -f /tmp/install_java.sh

# install alfresco
COPY assets/install_ephesoft.sh /tmp/install_ephesoft.sh
RUN /tmp/install_ephesoft.sh && \
    rm -f /tmp/install_ephesoft.sh

EXPOSE 8080

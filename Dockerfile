#gsdenys/ephesoft

FROM ubuntu:trusty
MAINTAINER Denys G. Santos <gsdenys@gmail.com>

#SO upgrade and dependency install
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y unzip ufw wget apt-utils software-properties-common
RUN apt-get -fy install
RUN apt-get autoremove
RUN apt-get autoclean

ENV EPEHSOFT_VERSION=4.0.2.0

#use the Dockerfile to download helps future build. Docker will mantain it cached
ADD http://www.ephesoft.com/Ephesoft_Product/Ephesoft_Community_$EPEHSOFT_VERSION/Ephesoft_Community_Release_$EPHESOFT_VERSION.zip /tmp/ephesoft.zip

# install ephesoft
COPY assets/install_ephesoft.sh /tmp/install_ephesoft.sh
RUN /tmp/install_ephesoft.sh && \
    rm -f /tmp/install_ephesoft.sh

EXPOSE 8080

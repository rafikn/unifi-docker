From java:8

MAINTAINER "RafikN <rafikn@secureme.co.nz> 

ENV UNIFI_VERSION 4.8.12
ENV MONGODB_VERSION 3.2
ENV UNIFI_DIR /opt/unifi

LABEL java_version=8 \
	  unifi_version=$UNIFI_VERSION \
	  mongodb_version=$MONGODB_VERSION

# Install mongodb
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927 && \
	echo "deb http://repo.mongodb.org/apt/debian wheezy/mongodb-org/3.2 main" | tee /etc/apt/sources.list.d/mongodb-org-$MONGODB_VERSION.list && \
	apt-get -y update && \
	apt-get -y install apt-utils && \
	apt-get -y install wget && \
	apt-get -y install unzip && \
	apt-get -y install mongodb-org-server

# Download and install unifi controller
RUN wget https://www.ubnt.com/downloads/unifi/$UNIFI_VERSION/UniFi.unix.zip && \
	unzip UniFi.unix.zip && \
	mv UniFi $UNIFI_DIR && \
	mkdir $UNIFI_DIR/data && \
	rm UniFi.unix.zip && \
	useradd unifi && \
	chown -R unifi: $UNIFI_DIR

WORKDIR $UNIFI_DIR
USER unifi

# 8080 device inform
# 8443 controller UI / API
# 8081 for management purpose
# 3478 UDP port used for STUN
EXPOSE 8080/tcp 8443/tcp 8081/tcp 3478/udp

VOLUME $UNIFI_DIR/data

ENTRYPOINT ["/usr/bin/java", "-Xmx1024M", "-jar", "/opt/unifi/lib/ace.jar"]
CMD ["start"]
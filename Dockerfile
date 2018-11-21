FROM java:openjdk-7-jdk

MAINTAINER Danilo Trani Recchia <danilo@deltatecnologia.com> 

ENV FILE https://www.collab.net/system/files/CollabNetSubversionEdge-5.2.2_linux-x86_64.tar_.gz

RUN apt-get update && \
	apt-get install -y sudo libmagic1 && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
	wget -q ${FILE} -O /tmp/csvn.tgz && \
	mkdir -p /opt/csvn && \
	tar -xzf /tmp/csvn.tgz -C /opt/csvn --strip=1 && \
	rm -rf /tmp/csvn.tgz

ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64
ENV RUN_AS_USER collabnet
	
RUN	useradd collabnet && \
	chown -R collabnet.collabnet /opt/csvn && \
	cd /opt/csvn && \
	./bin/csvn install
	
EXPOSE    3343 4434 18080 

#VOLUME /opt/csvn/data
#VOLUME /opt/csvn

COPY runme.sh /runme.sh

RUN	chmod +x /runme.sh

CMD /runme.sh 

FROM ubuntu:16.04

RUN echo "deb http://archive.ubuntu.com/ubuntu/ xenial multiverse" >> /etc/apt/sources.list \
 && apt-get update -qq \
 && apt-get install -qqy curl fontconfig wget cabextract xfonts-utils\
 && echo "ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula boolean true" \
  | debconf-set-selections \
 && curl -O "http://ftp.de.debian.org/debian/pool/contrib/m/msttcorefonts/ttf-mscorefonts-installer_3.6_all.deb" \
 && dpkg -i ttf-mscorefonts-installer_3.6_all.deb \
 && rm -rf /var/lib/apt/lists/* ttf-mscorefonts-installer_3.6_all.deb

RUN curl -sLH "Cookie: oraclelicense=accept-securebackup-cookie" \
    http://download.oracle.com/otn-pub/java/jdk/8u121-b13/e9e7ea248e2c4826b92b3f075a80e441/server-jre-8u121-linux-x64.tar.gz \
    | tar -xzf - -C /opt \
 && mv /opt/jdk1.8*/jre /opt/ \
 && rm -rf /opt/jdk1.8*

ENV INSTALL4J_JAVA_HOME='/opt/jre' \
    LANG='C.UTF-8' \
    LC_ALL='C.UTF-8' \
    LANGUAGE='C.UTF-8'

ADD ./config /a/config

RUN curl http://static.adito.de/common/install/ADITO4_4.6.50-RC5_unix.sh > /tmp/adito.sh \
 && chmod u+x /tmp/adito.sh \
 && /tmp/adito.sh -q -varfile /a/config/response.varfile \
 && rm -rf /tmp/*

EXPOSE 7934 7779 7778 7733 80

WORKDIR /opt/ADITO4

ADD ./start.sh /a/start.sh
RUN chmod u+x /a/start.sh
CMD /a/start.sh

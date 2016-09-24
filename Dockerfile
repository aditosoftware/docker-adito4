FROM ubuntu:16.04

RUN echo "deb http://archive.ubuntu.com/ubuntu/ xenial multiverse" >> /etc/apt/sources.list \
 && echo "ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula boolean true" \
    | debconf-set-selections \
 && apt-get update -qq && apt-get install -qqy curl fontconfig ttf-mscorefonts-installer \
 && rm -rf /var/lib/apt/lists/*

RUN curl -sLH "Cookie: oraclelicense=accept-securebackup-cookie" \
    http://download.oracle.com/otn-pub/java/jdk/8u102-b14/server-jre-8u102-linux-x64.tar.gz \
    | tar -xzf - -C /opt \
 && mv /opt/jdk1.8*/jre /opt/ \
 && rm -rf /opt/jdk1.8*

ENV INSTALL4J_JAVA_HOME='/opt/jre' \
    LANG='C.UTF-8' \
    LC_ALL='C.UTF-8' \
    LANGUAGE='C.UTF-8'

ADD ./config /a/config

RUN curl http://static.adito.de/common/install/ADITO4_4.5.80_unix_dnDlsoenDKLs308923nD.sh > /tmp/adito.sh \
 && chmod u+x /tmp/adito.sh \
 && /tmp/adito.sh -q -varfile /a/config/response.varfile \
 && rm -rf /tmp/*

EXPOSE 7779 7778 80

WORKDIR /opt/ADITO4

ADD ./start.sh /a/start.sh
RUN chmod u+x /a/start.sh
CMD /a/start.sh

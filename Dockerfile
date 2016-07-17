FROM ubuntu:16.04


RUN echo "deb http://archive.ubuntu.com/ubuntu/ xenial multiverse" >> /etc/apt/sources.list \
    && echo "ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula boolean true" | debconf-set-selections \
    && apt-get update -qq && apt-get install -qqy curl fontconfig ttf-mscorefonts-installer \
    && rm -rf /var/lib/apt/lists/*

RUN curl -sLH "Cookie: oraclelicense=accept-securebackup-cookie" \
    http://download.oracle.com/otn-pub/java/jdk/8u92-b14/server-jre-8u92-linux-x64.tar.gz | tar -xzf - -C /opt \
    && mv /opt/jdk1.8*/jre /opt/ \
    && rm -rf /opt/jdk1.8*

ENV INSTALL4J_JAVA_HOME='/opt/jre' \
    LANG='de_DE.UTF-8' \
    LANGUAGE='de_DE'

ADD ./config /a/config

RUN curl http://static.adito.de/common/install/ADITO4_4.5.60_unix_1ba86f37620c559c.sh > /tmp/adito.sh \
    && chmod u+x /tmp/adito.sh \
    && /tmp/adito.sh -q -varfile /a/config/response.varfile \
    && rm -rf /tmp/*

EXPOSE 7779 7778 80

ADD ./start.sh /a/start.sh
RUN chmod u+x /a/start.sh
CMD /a/start.sh

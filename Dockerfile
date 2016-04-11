FROM ubuntu:14.04


RUN apt-get update && apt-get install -y curl
RUN curl -jksSLH "Cookie: oraclelicense=accept-securebackup-cookie" \
    http://download.oracle.com/otn-pub/java/jdk/8u77-b03/server-jre-8u77-linux-x64.tar.gz | tar -xzf - -C /opt \
    && mv /opt/jdk1.8*/jre /opt/ \
    && rm -rf /opt/jdk1.8*

ENV INSTALL4J_JAVA_HOME /opt/jre

ADD ./config /a/config

RUN curl http://static.adito.de/common/4A902D3FB52DB5B62C62A82BB3CFAA72CE1742746FCD649/ADITO4_4.5.31_unix.sh > /tmp/adito.sh \
    && chmod u+x /tmp/adito.sh \
    && /tmp/adito.sh -q -varfile /a/config/response.varfile \
    && rm -rf /tmp/*

EXPOSE 7779 7778 80

ADD ./start.sh /a/start.sh
RUN chmod u+x /a/start.sh
CMD /a/start.sh


FROM ubuntu:14.04


RUN apt-get update && apt-get install -y curl
RUN curl -jksSLH "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u74-b02/server-jre-8u74-linux-x64.tar.gz | tar -xzf - -C /opt

ENV INSTALL4J_JAVA_HOME /opt/jdk1.8.0_74/jre
ADD ./config /a/config
RUN curl http://static.adito.de/common/8A5A3B71FCB0502A884AB8732EA72720C694E54633387BE483/ADITO4_4.4.50_unix.sh > /a/adito.sh \
    && chmod u+x /a/adito.sh \
    && /a/adito.sh -q -varfile /a/config/response.varfile-4.5 \
    && rm -f /a/adito.sh

EXPOSE 7779 7778 80

ADD ./start.sh /a/start.sh
CMD /a/start.sh


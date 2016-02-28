# Pull base image.
FROM ubuntu:14.04



# Install base stuff
ADD install/supervisor.sh /a/install/
RUN \
  echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee /etc/apt/sources.list.d/webupd8team-java.list && \
  echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee -a /etc/apt/sources.list.d/webupd8team-java.list && \
  apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886 && \
  apt-get update && \
  apt-get upgrade -y && \
  apt-get install -y oracle-java8-installer openssh-server nginx  && \
  /a/install/supervisor.sh && \
  rm -rf /var/cache/oracle-jdk8-installer && \
  rm -rf /var/lib/apt/lists/*

# Install ADITO4
ENV AO_VERSION 4.4.40
ADD install/adito.sh install/adito.varfile /a/install/
RUN /a/install/adito.sh ${AO_VERSION} F7F5AF98005051811FDE45D326580982B2762C43D27BE5F9187C186BB

# Additional Setup for ssh
RUN \
  mkdir /var/run/sshd && \
  cp /etc/ssh/sshd_config /etc/ssh/sshd_config~ &&\
  groupadd adito && \
  useradd -m -s /bin/bash -G adito,ssh aditouser



ENV ADATA /a/data
ENV AINIT /a/init
ENV ALOG /a/log

VOLUME ["/a/data", "/a/init", "/a/log"]

ADD init /a/init
RUN chmod +x /a/init/start

CMD ["/a/init/start"]
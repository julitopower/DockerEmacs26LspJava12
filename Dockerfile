FROM ubuntu:bionic

MAINTAINER Julio Delgado <julio.delgadomangas@gmail.com>

# Enable 256 ANSI colors for Emacs
ENV TERM xterm-256color
ENV HOME /root
ENV PATH ${PATH}:/root/.local/bin

# Install emacs26
RUN apt-get update -y && apt-get install software-properties-common -y && \
    add-apt-repository ppa:kelleyk/emacs -y && apt-get update -y && \
    apt install emacs26 sudo -y

# Install OpenJDK8
RUN add-apt-repository ppa:openjdk-r/ppa -y && apt-get update -y && \
    apt-get install openjdk-8-jdk -y
ENV JAVA_HOME /usr/lib/jvm/java-1.8.0-openjdk-amd64

# Install Maven3.5
RUN apt-get install wget -y && mkdir -p ~/maven-3.5/ && cd ~/maven-3.5/ && \
    wget https://repo.maven.apache.org/maven2/org/apache/maven/apache-maven/3.5.4/apache-maven-3.5.4-bin.tar.gz && \
    tar -xvzf apache-maven-3.5.4-bin.tar.gz

ENV PATH="$PATH:~/maven-3.5/apache-maven-3.5.4/bin/"

RUN rm -rf /var/lib/apt/lists/* \
    && sed -i "s/root\sALL=(ALL:ALL ) ALL/ALL    ALL = (ALL) NOPASSWD: ALL   /" /etc/sudoers \
    && touch /root/.emacs \
    && mkdir /root/.emacs.d

COPY emacs.d ${HOME}/.emacs.d
RUN rm -rf ${HOME}/.emacs && emacs --batch -l ${HOME}/.emacs.d/init.el

WORKDIR /opt/src/

From ubuntu:xenial

SHELL ["/bin/bash", "-c"]

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Moscow


COPY . .

RUN apt-get clean

RUN apt-get update && apt-get install -y libgtk2.0-0 libgtk-3-0 libgbm-dev libnotify-dev libgconf-2-4 libnss3 libxss1 libasound2 libxtst6 xauth xvfb gnupg curl wget git vim sudo postgresql postgresql-contrib tzdata zip unzip && \
    apt-get clean && \
    update-ca-certificates -f 


RUN export DEBIAN_FRONTEND=noninteractive && export DEBIAN_PRIORITY=critical &&\
wget https://dev.mysql.com/get/mysql-apt-config_0.8.10-1_all.deb &&\
export DEBIAN_FRONTEND=noninteractive && dpkg -i mysql-apt-config_0.8.10-1_all.deb &&\
apt install -y mysql-server mysql-client && apt-get -f install && usermod -d /var/lib/mysql/ mysql &&\
service mysql start 

RUN curl -s "https://get.sdkman.io" | bash 


RUN . "$HOME/.sdkman/bin/sdkman-init.sh" && sdk install java 17.0.1-tem 

ENV JAVA_HOME /Users/{user}/.sdkman/candidates/java/current


#### Install Maven
RUN export JAVA_HOME && wget https://dlcdn.apache.org/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz && mkdir -p /usr/local/apache-maven && mv apache-maven-3.6.3-bin.tar.gz /usr/local/apache-maven && cd /usr/local/apache-maven && tar -xzvf apache-maven-3.6.3-bin.tar.gz

ENV M2_HOME /usr/local/apache-maven/apache-maven-3.6.3
ENV M2 $M2_HOME/bin
ENV MAVEN_OPTS "-Xms256m -Xmx512m"
ENV PATH $M2:$PATH


## Install Spring Boot (3.1.3)
RUN export M2_HOME && export M2 && export MAVEN_OPTS && export PATH  && wget https://repo.spring.io/release/org/springframework/boot/spring-boot-cli/3.1.3.RELEASE/spring-boot-cli-3.1.3.RELEASE-bin.tar.gz && tar -xzf spring-boot-cli-3.1.3.RELEASE-bin.tar.gz && mv spring-3.1.3.RELEASE /opt/ && ln -s /opt/spring-3.1.3.RELEASE/bin/spring /usr/bin/spring && ln -s /opt/spring-boot-cli-3.1.3.RELEASE/shell-completion/bash/spring /etc/bash_completion.d/spring | sh






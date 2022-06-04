FROM debian:8.8

RUN apt-get -y update || true
RUN apt-get -y install wget tomcat7 && \
    wget https://raw.githubusercontent.com/opsxcq/exploit-CVE-2014-6271/master/packages/bash_4.2%252Bdfsg-0.1_amd64.deb -O bash.deb && \
    dpkg -i bash.deb && \
    apt-get -y install bash=4.2+dfsg-0.1 && \
    rm -f bash.deb

RUN apt-get -y install libssh-4

RUN mkdir /usr/share/tomcat7/temp

ENV PATH /usr/share/tomcat7/bin:"$PATH"

COPY tomcat-files/* /usr/share/tomcat7/conf/

RUN touch /mastercard

CMD ["catalina.sh", "run"]

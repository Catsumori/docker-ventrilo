FROM phusion/baseimage:0.9.16

CMD ["/sbin/my_init"]

RUN apt-get update
RUN apt-get install -y gcc-multilib

RUN curl -s "http://catomori.com/ventsrv.tar" -o /tmp/ventrilo.tar
RUN tar -zxf /tmp/ventrilo.tar -C /opt

ADD ventrilo_srv.ini /opt/ventsrv/ventrilo_srv.ini
ADD logrotate.conf /etc/logrotate.d/ventrilo

VOLUME /opt/ventsrv

RUN mkdir /etc/service/ventrilo
ADD ventrilo.sh /etc/service/ventrilo/run

EXPOSE 3784/tcp 3784/udp

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

FROM phusion/baseimage:0.9.16

CMD ["/sbin/my_init"]

RUN apt-get update
RUN apt-get install -y gcc-multilib

RUN curl -s "http://catomori.com/ventsrv/ventrilo_status" -o /opt/ventsrv/ventrilo_status
RUN curl -s "http://catomori.com/ventsrv/ventrilo_srv" -o /opt/ventsrv/ventrilo_srv
RUN curl -s "http://catomori.com/ventsrv/ventrilo_htm" -o /opt/ventsrv/ventrilo_htm
RUN curl -s "http://catomori.com/ventsrv/ventrilo_srv.ini" -o /opt/ventsrv/ventrilo_srv.ini
RUN curl -s "http://catomori.com/ventsrv/LICENSE" -o /opt/ventsrv/LICENSE

ADD ventrilo_srv.ini /opt/ventsrv/ventrilo_srv.ini
ADD logrotate.conf /etc/logrotate.d/ventrilo

VOLUME /opt/ventsrv

RUN mkdir /etc/service/ventrilo
ADD ventrilo.sh /etc/service/ventrilo/run

EXPOSE 3784/tcp 3784/udp

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

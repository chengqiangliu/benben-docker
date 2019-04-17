FROM logstash:7.0.0

COPY config/logstash.conf /opt/logstash/conf/logstash.conf
CMD ["-f", "/opt/logstash/conf/logstash.conf"]

EXPOSE 5044
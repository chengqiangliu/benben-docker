FROM logstash:6.7.0

RUN mkdir -p /opt/logstash/conf/
COPY config/logstash.conf /opt/logstash/conf/logstash.conf
RUN chmod +x /opt/logstash/conf/*.conf
CMD ["-f", "/opt/logstash/conf/logstash.conf"]

EXPOSE 5044
FROM benben/openjdk8

# for filebeat
ENV FILEBEAT_VERSION=6.4.2 \
    FILEBEAT_SHA1=e74d4dccdc6ab68dff08d09ddf937134466a7195

RUN wget https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-${FILEBEAT_VERSION}-linux-x86_64.tar.gz -O /opt/filebeat.tar.gz && \
  cd /opt && \
  echo "${FILEBEAT_SHA1}  filebeat.tar.gz" | sha1sum -c - && \
  tar xzvf filebeat.tar.gz && \
  cd filebeat-* && \
  cp filebeat /bin && \
  cd /opt && \
  rm -rf filebeat* && \
  rm -rf /tmp/* /var/tmp/*
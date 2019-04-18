FROM benben/openjdk8

# for filebeat
ENV FILEBEAT_VERSION=7.0.0 \
    FILEBEAT_SHA1=010986ca264c3fcde430860f8fd68b65ed06b44e

RUN wget https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-${FILEBEAT_VERSION}-linux-x86_64.tar.gz -O /opt/filebeat.tar.gz && \
  cd /opt && \
  echo "${FILEBEAT_SHA1}  filebeat.tar.gz" | sha1sum -c - && \
  tar xzvf filebeat.tar.gz && \
  cd filebeat-* && \
  cp filebeat /bin && \
  cd /opt && \
  rm -rf filebeat* && \
  rm -rf /tmp/* /var/tmp/*
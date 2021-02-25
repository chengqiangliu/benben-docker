FROM elasticsearch:7.0.0

RUN mkdir -p /opt/elasticearch/benben-node1/data && chmod 777 /opt/elasticearch/benben-node1/data
RUN mkdir -p /opt/elasticearch/benben-node1/logs && chmod 777 /opt/elasticearch/benben-node1/logs

COPY config/elasticsearch.yml /usr/share/elasticsearch/config/

EXPOSE 9200
EXPOSE 9300
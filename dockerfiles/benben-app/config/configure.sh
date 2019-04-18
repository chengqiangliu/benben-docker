#!/bin/bash

COMPONENT=$1
COMPONENT_VERSION=$2

START_SH=/opt/$COMPONENT/start.sh

mkdir -p /opt/filebeat
FILEBEAT_YML=/opt/filebeat/filebeat.yml

cat <<EOF > $FILEBEAT_YML
filebeat:
  prospectors:
    - input_type: stdin
      document_type: supervisor
      tags: [ "ffms" ]

output:
  logstash:
    hosts: ["benben.logstash:5677"]
    index: benben-filebeat
EOF

cat <<EOF > $START_SH
#!/bin/bash

cd /opt/$COMPONENT
java -jar $COMPONENT-$COMPONENT_VERSION.jar \
  --server.port=8080 \
  --logging.config=logback.groovy \
  --spring.config.location=application.yml \
  | filebeat -c $FILEBEAT_YML -e -v

EOF

chmod 755 $START_SH
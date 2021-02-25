FROM benben/filebeat

ARG COMPONENT
ARG COMPONENT_VERSION

RUN mkdir -p /opt/$COMPONENT /opt/install

COPY config/application.yaml config/logback.xml .tmp/$COMPONENT-$COMPONENT_VERSION.jar /opt/$COMPONENT/
COPY config/configure.sh /opt/install

RUN ln -s /opt/$COMPONENT /opt/gpp
RUN /opt/install/configure.sh $COMPONENT $COMPONENT_VERSION

ENTRYPOINT [ "/opt/benben/start.sh" ]
FROM benben/filebeat

ARG COMPONENT
ARG COMPONENT_VERSION

RUN mkdir -p /opt/$COMPONENT /opt/install

COPY application.yml logback.groovy .tmp/$COMPONENT-$COMPONENT_VERSION.jar /opt/$COMPONENT/
COPY configure.sh /opt/install

RUN ln -s /opt/$COMPONENT /opt/gpp
RUN /opt/install/configure.sh $COMPONENT $COMPONENT_VERSION

ENTRYPOINT [ "/opt/benben/start.sh" ]
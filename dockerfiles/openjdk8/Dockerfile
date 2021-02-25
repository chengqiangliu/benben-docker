FROM alpine:3.9

RUN apk update && \
  apk upgrade && \
  apk add --no-cache bash curl tar wget ca-certificates unzip openjdk8 && \
  rm -rf /var/cache/apk/*

ENV JAVA_HOME /usr/lib/jvm/java-1.8-openjdk
ENV PATH $PATH:/usr/lib/jvm/java-1.8-openjdk/bin
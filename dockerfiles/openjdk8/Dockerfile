FROM alpine:3.9

LABEL maintainer="chengqiang.liu"

ENV JAVA_HOME /usr/lib/jvm/java-1.8-openjdk
ENV PATH $PATH:/usr/lib/jvm/java-1.8-openjdk/jre/bin:/usr/lib/jvm/java-1.8-openjdk/bin
ENV JAVA_ALPINE_VERSION 8.181.13-r0

RUN apk add --no-cache bash curl tar wget ca-certificates unzip \
    openjdk8=${JAVA_ALPINE_VERSION} \
    && rm -rf /var/cache/apk/*

FROM alpine:latest

RUN apk update \
    && apk upgrade \
    && apk add curl wget bash openssl openjdk8 \
    && rm -rf /var/cache/apk/*

WORKDIR /root/

RUN wget https://download.elastic.co/elasticsearch/release/org/elasticsearch/distribution/tar/elasticsearch/2.4.6/elasticsearch-2.4.6.tar.gz -O elasticsearch-2.4.6.tar.gz

RUN tar -xf  elasticsearch-2.4.6.tar.gz -C /usr/local/ \
    && mv /usr/local/elasticsearch-2.4.6 /usr/local/elasticsearch \
    && mkdir /usr/local/elasticsearch/logs \
    && mkdir /usr/local/elasticsearch/data \
    && adduser -D -u 1000 -h /usr/local/elasticsearch elasticsearch \
    && chown -R elasticsearch /usr/local/elasticsearch

ENV JAVA_OPTS="-XX:PermSize=512m -XX:MaxPermSize=386m"

USER elasticsearch

CMD ["/usr/local/elasticsearch/bin/elasticsearch", "--cluster.name=es-cluster", "--node.name=${HOSTNAME}", "--path.data=/usr/local/elasticsearch/data", "--path.logs=/usr/local/elasticsearch/logs", "--network.host=0.0.0.0", "--discovery.zen.ping.unicast.hosts=es-master"]

EXPOSE 9200 9300
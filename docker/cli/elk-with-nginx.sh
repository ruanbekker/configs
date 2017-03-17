#!/bin/env bash

cat > logstash.conf << EOF
input {
  tcp {
    'port' => "9998"
    codec => json
  }
}

output {
  elasticsearch {
    host => es
    port => 9300
  }
}
EOF

# Elasticsearch:
docker run -d -p 9200:9200 -p 9300:9300 --name elasticsearch \
  dockerfile/elasticsearch \
  /elasticsearch/bin/elasticsearch \
  -Des.http.cors.enabled=true

# Kibana
docker run -d \
  --name kibana \
  -e ES_HOST="\"+window.location.hostname+\"" -e ES_PORT=9200 \
  -p 9292:80 \
  arcus/kibana

# Logstash:
docker run -d \
  --name logstash \
  --link elasticsearch:es \
  -p 9998:9998 \
  -p 9999:9999/udp \
  -v /Users/jwalton/logstash.conf:/opt/logstash.conf \
  pblittle/docker-logstash
  
  # docker data volume
  docker run -d --name nginx-conf -v /etc/nginx nginx echo "nginx config"
  
  # self signed for nginx-conf vol
  docker run -it --rm --volumes-from nginx-conf ubuntu bash
$ apt-get update
$ apt-get install openssl
$ mkdir /etc/nginx/ssl
$ cd /etc/nginx/ssl
$ openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/nginx.key -out /etc/nginx/ssl/nginx.crt
$ cd ..
$ apt-get install apache2-utils
$ htpasswd -c /etc/nginx/kibana.htpasswd username
$ mkdir /etc/nginx/sites-enabled

cat > kibana.conf << EOF
server {
    # we listen on :8080
    # listen       8080;

    # SSL
    listen       8080 ssl;
    server_name  somer.server;
    ssl_certificate      /etc/nginx/ssl/nginx.crt;
    ssl_certificate_key  /etc/nginx/ssl/nginx.key;

    ssl_session_cache shared:SSL:1m;
    ssl_session_timeout  5m;

    ssl_ciphers  HIGH:!aNULL:!MD5;
    ssl_prefer_server_ciphers   on;

    charset utf-8;

    # root for Kibana installation
    location / {
        auth_basic "Restricted";
        auth_basic_user_file /etc/nginx/kibana.htpasswd;

        proxy_http_version 1.1;
        proxy_set_header  X-Real-IP  $remote_addr;
        proxy_set_header  X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header  Host $http_host;
        proxy_pass http://kibana:80;
    }

    # and for elasticsearch
    location /es {
        auth_basic "Restricted - ES";
        auth_basic_user_file /etc/nginx/kibana.htpasswd;

        rewrite ^/es/_aliases$ /_aliases break;
        rewrite ^/es/_nodes$ /_nodes break;
        rewrite ^/es/(.*/_search)$ /$1 break;
        rewrite ^/es/(.*/_mapping)$ /$1 break;
        rewrite ^/es/(.*/_aliases)$ /$1 break;
        rewrite ^/es/(kibana-int/.*)$ /$1 break;
        return 403;

        proxy_http_version 1.1;
        proxy_set_header  X-Real-IP  $remote_addr;
        proxy_set_header  X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header  Host $http_host;
        proxy_pass http://es:9200;
    }

}
EOF

# copy config to data vol
docker run --rm -it --volumes-from nginx-conf -v ~:/home ubuntu bash
cp /home/kibana.conf /etc/nginx/conf.d/

# start up
# Elasticsearch:
docker run -d -p 9300:9300 --name elasticsearch \
  dockerfile/elasticsearch \
  /elasticsearch/bin/elasticsearch

# Kibana
docker run -d \
  --name kibana \
  -e ES_SCHEME="https" -e ES_HOST="\"+window.location.hostname+\"" -e ES_PORT="8080/es" \
  arcus/kibana

# Logstash:
docker run -d \
  --name logstash \
  --link elasticsearch:es \
  -p 9998:9998 \
  -p 9999:9999/udp \
  -v /Users/jwalton/logstash.conf:/opt/logstash.conf \
  pblittle/docker-logstash

# nginx:
docker run -d \
  --name nginx \
  --link elasticsearch:es \
  --link kibana:kibana \
  -p 8080:8080 \
  --volumes-from nginx-conf \
  nginx
  
  # http://www.thedreaming.org/2014/11/21/docker-logstash/
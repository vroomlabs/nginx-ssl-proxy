#!/usr/bin/env bash

docker stop tdalabs/nginx-ssl-proxy:latest
docker rm tdalabs/nginx-ssl-proxy:latest
docker rmi tdalabs/nginx-ssl-proxy:latest

docker build -t tdalabs/nginx-ssl-proxy:latest .

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
mkdir $DIR/ssl
openssl req -x509 -nodes -days 1825 -newkey rsa:2048 \
            -subj /C=US/ST=Delaware/L=Dover/O=ops/OU=dev/CN=example.org \
            -keyout ssl/nginx.key -out ssl/nginx.crt


#docker run --name=nginx-ssl-proxy:latest -v $DIR/ssl:/etc/nginx/ssl -p 30080:30080 -p 30443:30443 --net=host \
#	tdalabs/nginx-ssl-proxy:latest --http_port 30080 -S 30443 -a 127.0.0.1:8000

#	-it --entrypoint /bin/bash tdalabs/nginx-ssl-proxy:latest

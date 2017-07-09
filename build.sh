#!/usr/bin/env bash

docker stop nginx-ssl-proxy
docker rm nginx-ssl-proxy
docker rmi tdalabs/nginx-ssl-proxy:latest

docker build -t tdalabs/nginx-ssl-proxy:latest .

if [ "$1" = "run" ]; then

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
mkdir $DIR/ssl
openssl req -x509 -nodes -days 1825 -newkey rsa:2048 \
            -subj /C=US/ST=Delaware/L=Dover/O=ops/OU=dev/CN=example.org \
            -keyout ssl/nginx.key -out ssl/nginx.crt


docker run --name=nginx-ssl-proxy -v $DIR/ssl:/etc/nginx/ssl -p 30080:30080 -p 30443:30443 --net=host \
	tdalabs/nginx-ssl-proxy:latest --http_port 30080 -S 30443 -a http://127.0.0.1:8000
#	-it --entrypoint /bin/bash tdalabs/nginx-ssl-proxy:latest

fi

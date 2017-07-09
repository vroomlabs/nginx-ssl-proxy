#!/bin/bash
# Copyright 2015 Google Inc. All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
#you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and

#defaults
LISTEN_HTTP_PORT=80
LISTEN_HTTPS_PORT=443
LISTEN_STATUS_PORT=8090
BACKEND_SERVICE=127.0.0.1:8080

while [[ $# -gt 1 ]]
do
key="$1"

case $key in
    -p|--http_port)
    shift # past argument
	LISTEN_HTTP_PORT="$1"
    ;;
    -S|--ssl_port)
    shift # past argument
	LISTEN_HTTPS_PORT="$1"
    ;;
    -N|--status_port)
    shift # past argument
	LISTEN_STATUS_PORT="$1"
    ;;
    -a|--backend)
    shift # past argument
	BACKEND_SERVICE="$1"
    ;;
    *)
	# unknown option
	echo Unknown option "$1"
    ;;
esac
shift # past argument or value
done

PORTS_FILE=/etc/nginx/connections.conf
echo Generated file > $PORTS_FILE
echo set LISTEN_HTTP_PORT $LISTEN_HTTP_PORT >> $PORTS_FILE
echo set LISTEN_HTTPS_PORT $LISTEN_HTTPS_PORT >> $PORTS_FILE
echo set LISTEN_STATUS_PORT $LISTEN_STATUS_PORT >> $PORTS_FILE
echo set BACKEND_SERVICE $BACKEND_SERVICE >> $PORTS_FILE

echo "Starting nginx..."
nginx

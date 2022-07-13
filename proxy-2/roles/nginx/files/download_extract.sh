#!/bin/bash

version=$1

if [ -d ~/nginx ]; then
	exit 0
fi


curl "https://nginx.org/download/nginx-$version.tar.gz" -o /tmp/nginx.tar.gz
mkdir -p ~/nginx
tar -zxvf /tmp/nginx.tar.gz --directory ~/nginx --strip-components=1

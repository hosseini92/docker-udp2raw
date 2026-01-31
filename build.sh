#!/bin/bash

sudo docker build . -t docker-udp2raw:latest

### save image
# sudo docker save docker-udp2raw:latest | gzip > docker-udp2raw.tar.gz

### load image
# sudo docker load < docker-udp2raw.tar.gz
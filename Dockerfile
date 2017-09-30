FROM alpine:3.6
##FROM ubuntu
ADD . /pirl
RUN apk add --update bash && rm -rf /var/cache/apk/*
RUN \
  apk add --no-cache git go make gcc musl-dev linux-headers && \
  (cd pirl && make pirl)                             && \
  cp pirl/build/bin/pirl /usr/local/bin/             && \
  apk del git go make gcc musl-dev linux-headers            && \
  rm -rf /pirl
ADD start.sh /root/start.sh

EXPOSE 6588 30303 30303/udp

ENTRYPOINT /root/start.sh

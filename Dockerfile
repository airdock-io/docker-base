# VERSION 1.0
# AUTHOR:         Jerome Guibert <jguibert@gmail.com>
# DESCRIPTION:    Minimal image based on alpine
# TO_BUILD:       docker build --rm -t airdock/base .
# SOURCE:         https://github.com/airdock/docker-base

FROM alpine:3.2
MAINTAINER Jerome Guibert <jguibert@gmail.com>

#add root asset
ADD asset/ /root/

ENV LANG en_US.UTF-8
ENV LC_CTYPE en_US.UTF-8

# Install gosu 1.4
# add utilities (create user, post install script) and airdock usr list
RUN apk --update add curl gnupg && \
  gpg --keyserver pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 && \
  curl -o /usr/local/bin/gosu -SL "https://github.com/tianon/gosu/releases/download/1.4/gosu-amd64" && \
  curl -o /usr/local/bin/gosu.asc -SL "https://github.com/tianon/gosu/releases/download/1.4/gosu-amd64.asc" && \
  gpg --verify /usr/local/bin/gosu.asc && \
  rm /usr/local/bin/gosu.asc && \
  chmod +x /usr/local/bin/gosu /root/create-user /root/post-install; sync && \
  mkdir /srv && \
  /root/create-user redis 4201 redis 4201  && \
  /root/create-user elasticsearch 4202 elasticsearch 4202 && \
  /root/create-user mongodb 4203 mongodb 4203 && \
  /root/create-user rabbitmq 4204 rabbitmq 4204 && \
  /root/create-user java 4205 java 4205 && \
  /root/create-user py 4206 py 4206 && \
  apk del --purge curl gnupg && \
  /root/post-install

# Define default command.
CMD [ "/bin/sh"]

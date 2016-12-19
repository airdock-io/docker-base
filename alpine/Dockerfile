# VERSION 1.0
# AUTHOR:         Jerome Guibert <jguibert@gmail.com>
# DESCRIPTION:    Minimal image based on alpine
# TO_BUILD:       docker build --rm -t airdock/base .
# SOURCE:         https://github.com/airdock/docker-base

FROM gliderlabs/alpine:3.2
MAINTAINER Jerome Guibert <jguibert@gmail.com>

#add root asset
ADD asset/ /root/
ENV LANG en_US.UTF-8
ENV LC_CTYPE en_US.UTF-8
RUN set -x && \
  apk --no-cache add su-exec && \
  chmod +x /root/create-user /root/post-install; sync && \
  mkdir /srv && \
  /root/create-user redis 4201 redis 4201  && \
  /root/create-user elasticsearch 4202 elasticsearch 4202 && \
  /root/create-user mongodb 4203 mongodb 4203 && \
  /root/create-user rabbitmq 4204 rabbitmq 4204 && \
  /root/create-user java 4205 java 4205 && \
  /root/create-user py 4206 py 4206 && \
  /root/create-user node 4207 node 4207 && \
  /root/create-user docker 4242 docker 4242 && \
  /root/post-install

# Define default command.
CMD [ "/bin/sh"]
# VERSION 1.0
# AUTHOR:         Jerome Guibert <jguibert@gmail.com>
# DESCRIPTION:    Debian Stable image based on debian:jessie
# TO_BUILD:       docker build --rm -t airdock/base .
# SOURCE:         https://github.com/airdock/docker-base

# Pull base image.
FROM debian:jessie
MAINTAINER Jerome Guibert <jguibert@gmail.com>

USER root

# Never prompts the user for choices on installation/configuration of packages
ENV DEBIAN_FRONTEND noninteractive
# No dialog on apt-get update
ENV TERM linux
# Work around initramfs-tools running on kernel 'upgrade': <http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=594189>
ENV INITRD No

#add root asset (aliases and fix user id)
ADD asset/ /root/

# Install curl, locales, apt-utils and gosu 1.2
# create en_US.UTF-8
# update package
# add few common alias to root user
RUN apt-get update -qq && \
	apt-get install -y apt-utils curl locales && \
  apt-get update -y && \
	apt-get clean  && \
  gpg --keyserver pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 && \
  curl -o /usr/local/bin/gosu -SL "https://github.com/tianon/gosu/releases/download/1.2/gosu-$(dpkg --print-architecture)" && \
	curl -o /usr/local/bin/gosu.asc -SL "https://github.com/tianon/gosu/releases/download/1.2/gosu-$(dpkg --print-architecture).asc" && \
	gpg --verify /usr/local/bin/gosu.asc && \
	rm /usr/local/bin/gosu.asc && \
	chmod +x /usr/local/bin/gosu && \
  chmod +x /root/fix-user && \
  mv /root/aliases /root/.aliases && \
	echo "source ~/.aliases" >> /root/.bashrc && \
	localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8 && \
  rm -rf /var/lib/apt/lists/* /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Define en_US.
ENV LANG en_US.UTF-8

# Define default workdir
WORKDIR /root

# Define default command.
CMD [ "/bin/bash", "-l"]

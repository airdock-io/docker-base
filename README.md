# docker-base [![](https://badge.imagelayers.io/airdock/base:latest.svg)](https://imagelayers.io/?images=airdock/base:latest 'Get your own badge on imagelayers.io')

This project define our base image which rely on debian:jessie or gliderlabs/alpine

> Name: airdock/base

**Tags**:
 - latest, jessie: based on debian jessie
 - alpine: based on gliderlabs/alpine


## Features

### Common Features

 - Add [gosu](https://github.com/tianon/gosu) Jessie or [su-exec)(https://github.com/ncopa/su-exec) Alpine
 - add [tini](https://github.com/krallin/tini)
 - Add utility to create new container user with specific uid:gid (script '/root/create-user')
 - Following [FHS](http://refspecs.linuxfoundation.org/FHS_3.0/fhs-3.0.pdf) standard.
 - Add utility to clean up image during docker build (script '/root/post-install')
 - Define standard application user (with gosu/su-exec, you have all to run docker container with a user other than root)
 - Define LANG to en_US.UTF-8

### Debian Jessie

Under 'jessie' folder you could retreive:

 - Add curl (often used ...)
 - Apply security update if necessary
 - Fix some common docker build issue with apt-get
 - Define a root bash friendly for debug use

### Alpine

Under 'alpine' folder you could retreive common features. Did you say 'lightweight' ? ...


# Usage

You should have already install [Docker](https://www.docker.com/).

Execute: 'docker run -t -i  airdock/base:latest'

# Reading

We recommend to you spending time to read few documentation on [wiki](https://github.com/airdock-io/docker-base/wiki):
- [Docker Common Project Tree and build](https://github.com/airdock-io/docker-base/wiki/Docker-Project-Tree)
- [About user in Container](https://github.com/airdock-io/docker-base/wiki/How-Managing-user-in-docker-container) if you do something with docker volume (and you will do...)

And little more, if you want to create your own docker images:

- [Debian:jessy source](https://github.com/tianon/docker-brew-debian/tree/b6b91ab925802aff7b832127c278aba23d88d3d1/jessie)
- [Docker Alpine](https://github.com/gliderlabs/docker-alpine)
- [Official Repositories](http://docs.docker.com/docker-hub/official_repos/)
- [Docker Best practices](http://docs.docker.com/articles/dockerfile_best-practices/)
- From **Michael Crosby**:
	- [Best practices part I](http://crosbymichael.com/dockerfile-best-practices.html)
	- [Best practices part II](http://crosbymichael.com/dockerfile-best-practices-take-2.html)



# Change Log

## 2016/?/?
- start base alpine
- integrate jessie and alpine as base image
- add tini process managment

## 2016/12/18

- update gosu utility 1.9
- add 'docker' user (4242:4242)

## before

- use debian jessie distribution as our default system
- add gosu utility (1.7)
- configure default locale to en_US.UTF-8, set LC_ALL and LANG variable
- default command to "/bin/bash" with initialized shell
- fix build issue with docker (apt-get usage with term dialog, no init.d, add apt-utils)
- use MIT license
- set default working directory to /root,
- add few common aliases (see [Alias](http://www.cyberciti.biz/tips/bash-aliases-mac-centos-linux-unix.html) for more)
- add create-user script (utility to create 'standard user account')
- add post-install script (utility to clean up image in dockerfile )
- create all common user account used in airdock images
- define base of user and group identifier (4200) define in airdock images
- define '/srv/{user}' as data folder for application user with links on '/var/lib/{user}' for backward compatibility.

# Build

- Install "make" utility, and execute: `make build`
- Or execute: 'docker build -t airdock/base:latest --rm .'

See [Docker Project Tree](https://github.com/airdock-io/docker-base/wiki/Docker-Project-Tree) for more details.


# MIT License

```
The MIT License (MIT)

Copyright (c) 2015 Airdock.io

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
```

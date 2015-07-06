# docker-base

This project define our base image which rely on [alpine](https://github.com/gliderlabs/docker-alpine).

Alpine Linux is an independent, non-commercial, general purpose Linux distribution designed for power users who appreciate security, simplicity and resource efficiency.

> Name: airdock/base:alpine

**Dependency**: alpine:3.2

**Features**:

 - Add curl (often used ...)
 - Add [gosu 1.4](https://github.com/tianon/gosu)
 - Define LANG, LC_CTYPE to en_US.UTF-8
 - Add utility to create new container user with specific uid:gid (script '/root/create-user')
 - Add utility to clean up image during docker build (script '/root/post-install')
 - Following [FHS](http://refspecs.linuxfoundation.org/FHS_3.0/fhs-3.0.pdf) standard.

# Usage

You should have already install [Docker](https://www.docker.com/).

Execute: 'docker run -t -i  airdock/base:alpine'

# Reading

We recommend to you spending time to read few documentation on [wiki](https://github.com/airdock-io/docker-base/wiki):
- [Docker Common Project Tree and build](https://github.com/airdock-io/docker-base/wiki/Docker-Project-Tree)
- [About user in Container](https://github.com/airdock-io/docker-base/wiki/How-Managing-user-in-docker-container) if you do something with docker volume (and you will do...)

And little more, if you want to create your own docker images:

- [Alpine Linux]](http://alpinelinux.org/)
- [Official Repositories](http://docs.docker.com/docker-hub/official_repos/)
- [Docker Best practices](http://docs.docker.com/articles/dockerfile_best-practices/)
- From **Michael Crosby**:
	- [Best practices part I](http://crosbymichael.com/dockerfile-best-practices.html)
	- [Best practices part II](http://crosbymichael.com/dockerfile-best-practices-take-2.html)



# Change Log

## latest (current)

- use ALpine Linux distribution as our default system
- add gosu utility
- configure default locale to en_US.UTF-8, set LC_ALL and LANG variable
- use MIT license
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

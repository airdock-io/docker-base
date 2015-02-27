# docker-base

This repository contains **Dockerfile** for [Docker](https://www.docker.com/)'s [automated build](https://registry.hub.docker.com/u/airdock/) published to the public [Docker Hub Registry](https://registry.hub.docker.com/).

This define our base image which rely on debian:jessie.

> Name: airdock/debian

**Dependency**: debian:jessie

**Features**:

 - Add curl (often used ...)
 - Add [gosu 1.2](https://github.com/tianon/gosu)
 - Define LANG to en_US.UTF8
 - Apply security update if necessary
 - Fix some common docker build issue 
 - Define a root bash friendly for debug use

**Few links**:

- [Debian:jessy source](https://github.com/tianon/docker-brew-debian/tree/b6b91ab925802aff7b832127c278aba23d88d3d1/jessie)
- [Official Repositories](http://docs.docker.com/docker-hub/official_repos/)
- [Docker Best practices](http://docs.docker.com/articles/dockerfile_best-practices/)
- From **Michael Crosby**:
	- [part I](http://crosbymichael.com/dockerfile-best-practices.html)
	- [part II](http://crosbymichael.com/dockerfile-best-practices-take-2.html)


# Usage

1. You should have already install [Docker](https://www.docker.com/) and [Fig](http://www.fig.sh/) for more complex usage.
2. Download [automated build](https://registry.hub.docker.com/u/airdock/) from public [Docker Hub Registry](https://registry.hub.docker.com/):
`docker search airdock` or go directly in 3.
3. Execute: 'docker run -t -i  airdock/base:latest'


# How Managing user in docker container

We could waiting a little (or lot), and launch all our process as root in our docker container.
But, in fact, no... We recommand before reading more, to have a little reading time about [Docker Security Best Practice](http://linux-audit.com/docker-security-best-practices-for-your-vessel-and-containers/).

Your here ? greath.

When you create a user into a container, this user is not known for host machine. 
At this moment, if you mount a volume into this container, you could have some permission denied. 
A quick solution is to set r/w permission to 'other' on host volume. This is ok, but we can find a better way to handle this.


So, what we want to obtain ?

1. launch process in container with another account than 'root' (gosu utility help a lot to manage uid, and signal stories)
2. a local user in container must be "mapped" with another thing that a random user on host. Specialy when we user volume docker capability.    

To obtain this, we can do:

- for each user created in a container, we can set a dedicated uid
- on host, we can create a "docker" user with this dedicated uid, and manage his right.


For example, in debian jessy we have by default this list of user

```
root:x:0:0:root:/root:/bin/bash
daemon:x:1:1:daemon:/usr/sbin:/usr/sbin/nologin
bin:x:2:2:bin:/bin:/usr/sbin/nologin
sys:x:3:3:sys:/dev:/usr/sbin/nologin
sync:x:4:65534:sync:/bin:/bin/sync
games:x:5:60:games:/usr/games:/usr/sbin/nologin
man:x:6:12:man:/var/cache/man:/usr/sbin/nologin
lp:x:7:7:lp:/var/spool/lpd:/usr/sbin/nologin
mail:x:8:8:mail:/var/mail:/usr/sbin/nologin
news:x:9:9:news:/var/spool/news:/usr/sbin/nologin
uucp:x:10:10:uucp:/var/spool/uucp:/usr/sbin/nologin
proxy:x:13:13:proxy:/bin:/usr/sbin/nologin
www-data:x:33:33:www-data:/var/www:/usr/sbin/nologin
backup:x:34:34:backup:/var/backups:/usr/sbin/nologin
list:x:38:38:Mailing List Manager:/var/list:/usr/sbin/nologin
irc:x:39:39:ircd:/var/run/ircd:/usr/sbin/nologin
gnats:x:41:41:Gnats Bug-Reporting System (admin):/var/lib/gnats:/usr/sbin/nologin
nobody:x:65534:65534:nobody:/nonexistent:/usr/sbin/nologin
systemd-timesync:x:100:103:systemd Time Synchronization,,,:/run/systemd:/bin/false
systemd-network:x:101:104:systemd Network Management,,,:/run/systemd/netif:/bin/false
systemd-resolve:x:102:105:systemd Resolver,,,:/run/systemd/resolve:/bin/false
systemd-bus-proxy:x:103:106:systemd Bus Proxy,,,:/run/systemd:/bin/false
```

About UID Ranges, we known that:

- The system User IDs from 0 to 99 should be statically allocated by the system, and shall not be created by applications.
- The system User IDs from 100 to 499 should be reserved for dynamic allocation by system administrators and post install scripts using useradd.

Consult [Linux From Scratch Users List](http://www.linuxfromscratch.org/blfs/view/svn/postlfs/users.html) for more information about standard user Id.


We can decide that all our containerized user have an uid 1000, and his group id 1000 (Default minimal value UID_MIN and GID_MIN), or id 42 (uid for [dovecot](http://www.dovecot.org/))? And in the same time, removing unused user id (games, www-data, irc, ...) ?


So if we use a standard uid/gid like 42/42:

In a container, we can do something like:

	RUN /root/fix-user mylocaluser


After on a host, we can create a dedicated user (uid 42) with specific access on folder to mount with our container. 

```
groupadd my-docker-group -g 42
useradd -u 42 --home /home/my-docker-user --create-home --shell /bin/bash --no-user-group my-docker-user
usermod -g my-docker-group my-docker-user
```

# Change Log

## latest (current)

- base from debian jessie distribution
- add gosu utility
- configure default locale to en_US.UTF8
- default command to "/bin/bash" with initialized shell
- fix build issue with docker (term dialog, no init.d, add apt-utils)
- use Expat/MIT license
- set default working directoty to /root
- add fix-user script

# Build

You can build an image from [Dockerfile](https://github.com/airdock-io/docker-base):

- Install "make" utility, and execute: `make build`
- Or execute: 'docker build -t airdock/base:latest --rm .'

In Makefile, you could retreive this *variables*:

- NAME: declare a full image name (aka airdock/base)
- VERSION: declare image version

and *tasks*:

- **all**: alias to 'build'
- **clean**: remove all container which depends on this image, and remove image previously builded
- **build**: clean and build the current version
- **tag_latest**: build and tag current version with ":latest"
- **release**: execute tag_latest, push image onto registry, and tag git repository
- **debug**: launch default command with builded image in interactive mode
- **run**: run image as daemon and print IP address.



# License

```
 Copyright (c) 1998, 1999, 2000 Thai Open Source Software Center Ltd

 Permission is hereby granted, free of charge, to any person obtaining
 a copy of this software and associated documentation files (the
 "Software"), to deal in the Software without restriction, including
 without limitation the rights to use, copy, modify, merge, publish,
 distribute, sublicense, and/or sell copies of the Software, and to
 permit persons to whom the Software is furnished to do so, subject to
 the following conditions:

 The above copyright notice and this permission notice shall be included
 in all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
 IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
 CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
 TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
 SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 ```

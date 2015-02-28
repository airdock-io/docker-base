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
 - Fix some common docker build issue with apt-get
 - Define a root bash friendly for debug use
 - Add utility to map new container user with specific uid:gid

**Few links**:

- [Debian:jessy source](https://github.com/tianon/docker-brew-debian/tree/b6b91ab925802aff7b832127c278aba23d88d3d1/jessie)
- [Official Repositories](http://docs.docker.com/docker-hub/official_repos/)
- [Docker Best practices](http://docs.docker.com/articles/dockerfile_best-practices/)
- From **Michael Crosby**:
	- [part I](http://crosbymichael.com/dockerfile-best-practices.html)
	- [part II](http://crosbymichael.com/dockerfile-best-practices-take-2.html)


# Usage

You should have already install [Docker](https://www.docker.com/) and [Fig](http://www.fig.sh/) for more complex usage.
Download [automated build](https://registry.hub.docker.com/u/airdock/) from public [Docker Hub Registry](https://registry.hub.docker.com/):
`docker search airdock` or go directly in 3.

Execute: 'docker run -t -i  airdock/base:latest'



# How Managing user in docker container

We could waiting a little (or lot), and launch all our process as root in our docker container.
Even if the root container user is not a real root user, we think we should do something about this.
We recommend you to have a little reading time about [Docker Security Best Practice](http://linux-audit.com/docker-security-best-practices-for-your-vessel-and-containers/).

Your here ? great.

So, when you create a user into a container, this user is not known for host machine.
At this moment, if you mount a volume into this container, you could have some permission denied.
A quick and ugly solution is to set r/w permission to 'other' on host volume.


So, what we want to obtain ?

1. launch process in container with another account than 'root' (gosu utility help a lot to manage uid, and signal stories)
2. map local user in container with another thing that a random user on host. Specially when we use volume docker capability.

To obtain this, we can do:

- for each user created in a container, we can set a dedicated uid
- for each group created in a container, we can set a dedicated gid
- on host, we can create a "docker" user with those dedicated uid/gid, and manage permissions.

It is simply a statical mapping of user between container and host. The draw back of this, it's that we have something to do on host.

For example, in debian jessy we have by default this list of user (at the time of writing those lines)

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


### First solution: map all container user in a single host user:group

So if we use a standard uid/gid like 42/42 (uid for [dovecot](http://www.dovecot.org/)):

In a container, we can do something like:

```
  # user uid gid
	RUN /root/fix-user mylocaluser 42 42
```

And on host, we can create a dedicated user (uid 42) with specific access on folder to mount with our container.

```
  sudo groupadd my-docker-group -g 42
  sudo useradd -u 42 --home /home/my-docker-user --create-home --shell /bin/bash --no-user-group my-docker-user
  sudo usermod -g my-docker-group my-docker-user
```

It enough to manage quickly their permission.
But all container cannot have their own 'private' storage on host. A little too ugly yet.


### Solution: Use a static standardized map of user

It means that we maintains a [static table](https://github.com/airdock-io/docker-base/blob/master/CommonUserList.md) of user/group per application.
And for each image using a dedicated user, we add a little notice which explain:

- how adding specific user on host
- how set permission on a folder mounted as a volume


So for each image which create a specific user :

- We add an entry in our [Common User List](https://github.com/airdock-io/docker-base/blob/master/CommonUserList.md)
- Add a run directive in dockerfile to force correct uid/gid of container user
- Add a short notice about user creation and permission in readme.



# Change Log

## latest (current)

- use debian jessie distribution as our default system
- add gosu utility
- configure default locale to en_US.UTF-8
- default command to "/bin/bash" with initialized shell
- fix build issue with docker (apt-get usage with term dialog, no init.d, add apt-utils)
- use Expat/MIT license
- set default working directory to /root, add few common aliases
- add fix-user script (utility to map container user to specific uid:gid)

# Build

You can build an image from [Dockerfile](https://github.com/airdock-io/docker-base):

- Install "make" utility, and execute: `make build`
- Or execute: 'docker build -t airdock/base:latest --rm .'

In Makefile, you could retrieve this *variables*:

- NAME: declare a full image name (aka airdock/base)
- VERSION: declare image version

and *tasks*:

- **all**: alias to 'build'
- **clean**: remove all container which depends on this image, and remove image previously builded
- **build**: clean and build the current version
- **tag_latest**: tag current version with ":latest"
- **release**: build and execute tag_latest, push image onto registry, and tag git repository
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

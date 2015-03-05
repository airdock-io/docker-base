# Common User List


See [How Managing user in docker container](https://github.com/airdock-io/docker-base/blob/master/README.md#how-managing-user-in-docker-container).


For all defined user, we will start id from 4200. In the range 1000-29999 dedicated for dynamically allocated user accounts.
All of them are ever define in our docker base image.


|  Image                  | User:Group                     | User Identifier | Group Identifier |
| ----------------------- | ------------------------------ | --------------- | ---------------- |
| airdock/redis           | redis:redis                    | 4201            | 4201             |
| airdock/elasticsearch   | elasticsearch:elasticsearch    | 4202            | 4202             |
| airdock/mongodb         | mongodb:mongodb                | 4203            | 4203             |
| airdock/nginx           | www-data:www-data              |  33             |  33              |
| airdock/apache          | www-data:www-data              |  33             |  33              |
| airdock/rabbitmq        | rabbitmq:rabbitmq              | 4204            | 4204             |
|                         |                                |                 |                  |



### create Guest user and group

You can, in your dockerfile use script

```
/root/create-user username uid  groupname gid
``

to create username and groupname with specified id.


### Create Host user and group

You can do:

```
  sudo groupadd my-docker-group -g 4201
  sudo useradd -u 4201  --no-create-home --system --no-user-group my-docker-user
  sudo usermod -g my-docker-group my-docker-user
```

or call this script which create all user:

```
  create-all-user
```

### Standard User Define in debian Jessie

| name          | uid     | gid    |
| ------------- | ------- | ------ |
| root | 0 |
| daemon  | 1 |
| bin | 2 |
| sys | 3 |
| sync | 4 |
| games | 5 |
| man | 6 |
| lp | 7 |
| mail | 8 |
| news | 9 |
| uucp | 10 |
| proxy  | 13 |
| www-data | 33
| backup | 34 |
| list | 38
| irc | 39
| gnats | 41 |
| nobody | 65534 |
| systemd-timesync |  100|  103
| systemd-network |  101 |  104
| systemd-resolve | 102 |  105
| systemd-bus-proxy |  103 |  106

# Common User List


See [How Managing user in docker container](https://github.com/airdock-io/docker-base/blob/master/README.md#how-managing-user-in-docker-container).


|  Image                  | User:Group                     | User Identifier | Group Identifier |
| ----------------------- | ------------------------------ | --------------- | ---------------- |
| airdock/redis           | redis:redis                    | 101             | 101              |
| airdock/elasticsearch   | elasticsearch:elasticsearch    | 102             | 102              |
| airdock/mongodb         | mongodb:mongodb                | 103             | 103              |
| airdock/nginx           | www-data:www-data              |  33             |  33              |
| airdock/apache          | www-data:www-data              |  33             |  33              |
|                         |                                |                 |                  |




### Create Host user and group


```
  sudo groupadd my-docker-group -g 42
  sudo useradd -u 42  --no-create-home --system --no-user-group my-docker-user
  sudo usermod -g my-docker-group my-docker-user
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

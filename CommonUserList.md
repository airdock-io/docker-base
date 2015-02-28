# Common User List


See [How Managing user in docker container](https://github.com/airdock-io/docker-base/blob/master/README.md#how-managing-user-in-docker-container).


|  Image                  | User:Group                     | User Identifier | Group Identifier |
| ----------------------- | ------------------------------ | --------------- | ---------------- |
| airdock/redis           | redis:redis                    | 101             | 101              |
| airdock/elasticsearch   | elasticsearch:elasticsearch    | 102             | 102              |
| airdock/mongodb         |                                |                 |                  |
|                         |                                |                 |                  |
|                         |                                |                 |                  |






### Create Host user and group


```
  sudo groupadd my-docker-group -g 42
  sudo useradd -u 42  --no-create-home --system --no-user-group my-docker-user
  sudo usermod -g my-docker-group my-docker-user
```

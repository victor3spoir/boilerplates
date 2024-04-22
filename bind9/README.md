
```bash
docker network create --driver bridge --subnet=172.18.0.0/16 --gateway=172.18.0.1 --dns=<BIND_CONTAINER_IP> my-network

```
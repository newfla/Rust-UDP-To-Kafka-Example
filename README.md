# Tokio-To-kafka

Showcase example for [Rust-UDP-To-Kafka-Forwarding](https://github.com/newfla/Rust-UDP-To-Kafka-Forwarding) and [Rust-UDP-To-Kafka-Forwarding](https://github.com/newfla/Rust-UDP-Traffic-Generator) running on docker

# Prerequistes
- Git
- Docker engine [Installation Guide](https://docs.docker.com/engine/install)

# Build Run
```
./launch_me.sh -b -r
```

# Bigger Sockets
To avoid packets drops on high-load scenarios, add the following lines to **/etc/sysctl.conf**
- *net.core.rmem_default=104857600*
- *net.core.rmem_max=104857600*
- *net.core.wmem_default=104857600*
- *net.core.wmem_max=104857600*

Apply the changes
```
sudo sysctl -p
```

# Useful Commands
- docker logs -f forwarder
- docker logs -f client
- docker logs -f consumer
- watch -n2 docker exec -it forwarder cat /proc/net/udp
- watch -n2 docker exec -it client cat /proc/net/udp
- docker stats

FROM rust:latest as base_builder
RUN apt update && \
    apt install -y curl wget build-essential cmake zlib1g-dev libzstd-dev protobuf-compiler

FROM base_builder as builder
WORKDIR /forwarder
COPY forwarder/Cargo.toml .
COPY forwarder/src src
COPY forwarder/tasks tasks
COPY forwarder/utilities utilities
RUN cargo build -r

FROM base_builder as cert_downloader 
WORKDIR /cert
RUN wget https://raw.githubusercontent.com/drogue-iot/tokio-dtls-stream-sink/main/tests/certs/server-cert.pem && \
    wget https://raw.githubusercontent.com/drogue-iot/tokio-dtls-stream-sink/main/tests/certs/server-key.pem

FROM ubuntu:jammy
COPY --from=builder /forwarder/target/release/udp_to_kafka_forwarding /forwarder
COPY --from=cert_downloader /cert /
ENTRYPOINT [ "/forwarder" ]

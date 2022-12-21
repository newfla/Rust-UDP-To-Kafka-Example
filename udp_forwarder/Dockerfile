FROM rust:latest as base_builder
RUN apt update && \
    apt install -y curl build-essential cmake zlib1g-dev libzstd-dev

FROM base_builder as builder
WORKDIR /forwarder
COPY forwarder/Cargo.toml .
COPY forwarder/src src
COPY forwarder/tasks tasks
COPY forwarder/utilities utilities
RUN cargo build -r

FROM ubuntu:jammy
COPY --from=builder /forwarder/target/release/udp_to_kafka_forwarding /forwarder
ENTRYPOINT [ "/forwarder" ]
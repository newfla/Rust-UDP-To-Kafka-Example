FROM rust:latest as base_builder
RUN apt update && \
    apt install -y curl wget build-essential cmake zlib1g-dev libzstd-dev protobuf-compiler libssl-dev libssl-dev libsasl2-dev && \
    cargo install cargo-chef

FROM base_builder as cert_downloader 
WORKDIR /cert
RUN wget https://raw.githubusercontent.com/drogue-iot/tokio-dtls-stream-sink/main/tests/certs/server-cert.pem && \
    wget https://raw.githubusercontent.com/drogue-iot/tokio-dtls-stream-sink/main/tests/certs/server-key.pem

FROM base_builder as builder_with_src
WORKDIR /forwarder
COPY forwarder/Cargo.toml .
COPY forwarder/README.md .
COPY forwarder/src src
COPY forwarder/examples examples

FROM builder_with_src AS planner
RUN cargo chef prepare --recipe-path recipe.json

FROM builder_with_src AS builder
COPY --from=planner /forwarder/recipe.json recipe.json
RUN cargo chef cook --release --recipe-path recipe.json
RUN cargo build -r --example udp_to_kafka

FROM ubuntu:jammy
RUN apt update && \
    apt install -y libsasl2-2
COPY --from=builder /forwarder/target/release/examples/udp_to_kafka /forwarder
COPY --from=cert_downloader /cert /
ENTRYPOINT [ "/forwarder" ]

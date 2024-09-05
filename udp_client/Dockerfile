FROM rust:latest AS base_builder
RUN apt update && \
    apt install -y curl build-essential cmake zlib1g-dev wget

FROM base_builder AS builder
WORKDIR /client
COPY client/Cargo.toml .
COPY client/src src
RUN cargo build -r

FROM base_builder AS cert_downloader 
WORKDIR /cert
RUN wget https://raw.githubusercontent.com/drogue-iot/tokio-dtls-stream-sink/main/tests/certs/ca-cert.pem

FROM ubuntu:jammy
COPY --from=builder /client/target/release/crab-net /client
COPY --from=cert_downloader /cert /
COPY run_client.sh .
ENV WORKERS=2
ENTRYPOINT [ "./run_client.sh" ]

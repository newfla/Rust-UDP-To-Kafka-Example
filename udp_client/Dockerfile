FROM rust:latest as base_builder
RUN apt update && \
    apt install -y curl build-essential cmake zlib1g-dev wget && \
    cargo install cargo-chef

FROM base_builder as cert_downloader 
WORKDIR /cert
RUN wget https://raw.githubusercontent.com/drogue-iot/tokio-dtls-stream-sink/main/tests/certs/ca-cert.pem

FROM base_builder as builder_with_src
WORKDIR /client
COPY client/Cargo.toml .
COPY client/src src

FROM builder_with_src AS planner
RUN cargo chef prepare --recipe-path recipe.json

FROM builder_with_src AS builder
COPY --from=planner /client/recipe.json recipe.json
RUN cargo chef cook --release --recipe-path recipe.json
RUN cargo build -r

FROM ubuntu:jammy
COPY --from=builder /client/target/release/crab-net /client
COPY --from=cert_downloader /cert /
COPY run_client.sh .
ENV WORKERS=2
ENTRYPOINT [ "./run_client.sh" ]

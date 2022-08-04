FROM ubuntu:jammy as base_builder
RUN apt update && \
    apt install -y curl build-essential cmake zlib1g-dev &&\
    curl https://sh.rustup.rs -sSf | bash -s -- -y

ENV PATH="/root/.cargo/bin:${PATH}"

FROM base_builder as builder
WORKDIR /server
COPY server/.cargo .cargo
COPY server/Cargo.toml .
COPY server/src src
COPY server/tasks tasks
COPY server/utilities utilities
RUN cargo build -r

FROM ubuntu:jammy
COPY --from=builder /server/target/release/udp_to_kafka_forwarding /server
ENTRYPOINT [ "/server" ]
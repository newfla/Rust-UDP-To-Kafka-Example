FROM rust:latest as base_builder
RUN apt update && \
    apt install -y curl build-essential cmake zlib1g-dev 


FROM base_builder as builder
WORKDIR /client
COPY client/Cargo.toml .
COPY client/src src
RUN cargo build -r

FROM ubuntu:jammy
COPY --from=builder /client/target/release/udp_traffic_generator /client
ENV WORKERS=2
ENTRYPOINT ./client -d $DEST_ADDR -c $CONNECTIONS -l $PAYLOAD_SIZE -r $RATE -w $WORKERS -s $SLEEP_TASK_SPAWN
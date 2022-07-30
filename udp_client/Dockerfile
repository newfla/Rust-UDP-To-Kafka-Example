FROM ubuntu:jammy as base_builder
RUN apt update && \
    apt install -y curl build-essential cmake &&\
    curl https://sh.rustup.rs -sSf | bash -s -- -y

ENV PATH="/root/.cargo/bin:${PATH}"

FROM base_builder as builder
WORKDIR /client
COPY client/Cargo.toml .
COPY client/src src
COPY client/.cargo .cargo
RUN cargo build -r

FROM ubuntu:jammy
COPY --from=builder /client/target/release/udp_traffic_generator /client
ENV WORKERS=2
ENTRYPOINT ./client -d $DEST_ADDR -c $CONNECTIONS -l $PAYLOAD_SIZE -r $RATE -w $WORKERS
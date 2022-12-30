FROM ubuntu:jammy as downloader
WORKDIR /download
ADD https://github.com/protocolbuffers/protobuf/releases/download/v21.12/protoc-21.12-linux-x86_64.zip protoc.zip
RUN apt update && \
    apt install -y unzip && \
    unzip protoc.zip && \
    ls -altr

FROM confluentinc/cp-kafkacat:latest
WORKDIR /RUN
COPY run_kafkacat.sh .
COPY message.proto .
COPY --from=downloader /download/bin/ .
ENV PATH="$PATH:/RUN/"
ENTRYPOINT [ "./run_kafkacat.sh" ]
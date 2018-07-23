FROM ubuntu:18.04
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        musl-tools binutils upx-ucl wget make libc6-dev \
    && rm -rf /var/lib/apt/lists/*
RUN wget http://www.muppetlabs.com/~breadbox/pub/software/ELFkickers-3.1.tar.gz && \
    tar xf ELFkickers-3.1.tar.gz && cd ELFkickers-3.1 && \
    make && install sstrip/sstrip /usr/local/bin/ && \
    cd .. && rm -rf ELFkickers*
WORKDIR /build
RUN mkdir -p /build/nweb /build/server
COPY build-nweb.sh .
COPY nweb/nweb23.c nweb/
RUN ./build-nweb.sh

FROM busybox
COPY server /server
COPY --from=0 /build/server/nweb.tar.gz /server/
EXPOSE 80
ENTRYPOINT ["/server/run.sh"]

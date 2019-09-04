FROM ubuntu:xenial
ADD Zeronet/build.sh build.sh
RUN chmod +x build.sh
RUN ./build.sh

FROM ubuntu:xenial
WORKDIR /root/
COPY --from=0 /tezos/tezos-* /usr/local/bin/
COPY --from=0 /tezos /tezos
RUN apt update && apt-get install -y libgmp-dev libev-dev libusb-dev libhidapi-dev
RUN echo -e "http\t80/tcp\twww\t# WorldWideWeb HTTP" > /etc/services

RUN apt-get update && \
 yes | apt-get install -y htop aria2 wget curl git pydf mtr ack-grep nano unzip
RUN aria2c https://github.com/ogham/exa/releases/download/v0.9.0/exa-linux-x86_64-0.9.0.zip && \
 unzip exa-linux-x86_64-0.9.0.zip && \
 cp exa-linux-x86_64 /usr/local/bin/exa && rm * && \
 echo "alias ls=\"exa\"" >> ~/.bashrc
ADD ./scripts/import /usr/local/bin/import
RUN chmod +x /usr/local/bin/import
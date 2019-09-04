FROM ubuntu:latest

# Install dependencies
RUN apt-get update && \
    apt-get install -y software-properties-common && \
    apt-get dist-upgrade -y && \
    add-apt-repository ppa:git-core/ppa && \
    apt-get update -y && \
    apt-get install -y git && \
    apt-get install -y wget patch unzip make gcc m4 git g++ aspcud bubblewrap curl bzip2 rsync libev-dev libgmp-dev pkg-config libhidapi-dev

# Install OPAM 2.0.2
RUN wget https://github.com/ocaml/opam/releases/download/2.0.2/opam-2.0.2-x86_64-linux && \
    mv opam-2.0.2-x86_64-linux /usr/local/bin/opam && \
    chmod a+x /usr/local/bin/opam

# Initialize OPAM, disable sandboxing, otherwise bubblewrap won't work in docker
RUN opam init --compiler=4.07.1 --disable-sandboxing

RUN eval $(opam env) && \
    git clone -b mainnet https://gitlab.com/tezos/tezos.git && \
    cd tezos && \
    git checkout alphanet && \
    git status && \
    export OPAMYES=true && \
    make build-deps

RUN cd tezos && \
    eval $(opam env) && \
make


RUN apt-get update && \
 yes | apt-get install -y htop aria2 wget curl git pydf mtr ack-grep nano unzip
RUN aria2c https://github.com/ogham/exa/releases/download/v0.9.0/exa-linux-x86_64-0.9.0.zip && \
 unzip exa-linux-x86_64-0.9.0.zip && \
 cp exa-linux-x86_64 /usr/local/bin/exa && rm exa-linux-x86_64-0.9.0.zip && \
 echo "alias ls=\"exa\"" >> ~/.bashrc
ADD ./scripts/import /usr/local/bin/import
RUN chmod +x /usr/local/bin/import

COPY ./scripts/tezos-init-sandboxed-client.sh /tezos/src/bin_client/tezos-init-sandboxed-client.sh
COPY ./scripts/start.sh /usr/local/bin/start-sandbox

RUN chmod +x /tezos/src/bin_client/tezos-init-sandboxed-client.sh
RUN chmod +x /usr/local/bin/start-sandbox
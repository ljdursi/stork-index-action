FROM ubuntu:focal

RUN apt update \
    && apt install -y wget

# install stork
WORKDIR /tmp
RUN wget https://files.stork-search.net/releases/v1.2.1/stork-ubuntu-20-04 \
    && chmod +x stork-ubuntu-20-04 \
    && mv stork-ubuntu-20-04 /usr/local/bin/stork

# install the script we use to create the index
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

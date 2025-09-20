FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV PATH="/usr/games:${PATH}"

RUN apt-get update && apt-get install -y \
    bash \
    cowsay \
    fortune-mod \
    netcat-openbsd \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src/app
COPY wisecow.sh /usr/src/app/wisecow.sh
RUN chmod +x /usr/src/app/wisecow.sh

EXPOSE 4499
CMD ["/usr/src/app/wisecow.sh"]

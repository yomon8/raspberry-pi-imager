FROM ubuntu:focal

RUN apt-get update -qq \
 && DEBIAN_FRONTEND=noninteractive apt-get install -qqy \
  qemu-user-static \
  kpartx \
  unzip \
  wget \
  curl \
  sudo \
  ansible \
 && rm -rf /var/lib/apt/lists/*

ENV PACKER_VERSION 1.6.0

RUN wget https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip -O /tmp/packer.zip && \
  unzip /tmp/packer.zip -d /bin && \
  rm /tmp/packer.zip
WORKDIR /build

RUN wget https://github.com/solo-io/packer-builder-arm-image/releases/download/v0.1.6/packer-builder-arm-image -O /usr/bin/packer-builder-arm-image

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
RUN chmod +x /usr/bin/packer-builder-arm-image
ENTRYPOINT ["/entrypoint.sh"]

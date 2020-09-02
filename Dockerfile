FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive
RUN echo "APT::Get::Assume-Yes \"true\";" > /etc/apt/apt.conf.d/90assumeyes

# Install required packages
RUN apt-get update && \
        apt-get install -y --no-install-recommends \
         ca-certificates \
         curl \
         jq \
         git \
         iputils-ping \
         netcat \
         unzip

# Clean system
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

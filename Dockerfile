FROM ubuntu:18.04 as installer

# Create installer
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
         unzip \
         python3-pip

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
RUN unzip awscliv2.zip
RUN ./aws/install --bin-dir /aws-cli-bin/

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
         unzip \
         python3-pip

# Copy AWS Cli from previous image
COPY --from=installer /usr/local/aws-cli/ /usr/local/aws-cli/
COPY --from=installer /aws-cli-bin/ /usr/local/bin/

# Clean system
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

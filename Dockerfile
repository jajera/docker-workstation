FROM ubuntu:latest

# set timezone
RUN ln -snf /usr/share/zoneinfo/$CONTAINER_TIMEZONE /etc/localtime && echo $CONTAINER_TIMEZONE > /etc/timezone

# install prerequisites
RUN apt-get update && apt-get install -y apt-utils \
    bash-completion \
    build-essential \
    curl \
    git \
    gnupg \
    iputils-ping \
    libssl-dev \
    libffi-dev \
    python3-dev \
    python3-jmespath \
    python3-pip \
    software-properties-common \
    sshpass \
    tree \
# install terraform
    && curl -s https://apt.releases.hashicorp.com/gpg | gpg --dearmor > hashicorp.gpg \
    && install -o root -g root -m 644 hashicorp.gpg /etc/apt/trusted.gpg.d/ \
    && apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main" \
    && apt-get update && apt-get install terraform \
# install ansible
    && apt-get update && apt-get install -y ansible \
    && python3 -m pip install paramiko \
# install command autocomplete
    && echo "source /etc/profile.d/bash_completion.sh" >> ~/.bashrc \
# run update
    && apt-get update

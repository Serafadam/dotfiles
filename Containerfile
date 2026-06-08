ARG IMAGE=ubuntu:26.04
FROM ${IMAGE}
ENV DEBIAN_FRONTEND=noninteractive
ARG DOCKER_USER=test_user
ENV UV_SYSTEM_PYTHON=1
ENV RUSTUP_HOME=/opt/rust
ENV CARGO_HOME=/opt/rust
ENV NVM_DIR=/opt/.nvm
ENV PATH="/opt/rust/bin:${PATH}"
ENV PATH="/opt/.fzf/bin:${PATH}"

RUN mkdir -p /opt/rust && \
    chmod -R 777 /opt/rust
WORKDIR /ws
COPY ./install.sh /ws/install.sh 

RUN sh /ws/install.sh
COPY ./nvm_install.sh /ws/nvm_install.sh

RUN sh /ws/nvm_install.sh
RUN chmod -R 777 /opt/.nvm
RUN usermod -l ${DOCKER_USER} ubuntu

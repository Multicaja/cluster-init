FROM python:2-alpine3.9

WORKDIR /app

COPY ansible.cfg /etc/ansible/

RUN apk update && \
    apk add ansible libffi-dev openssl-dev gcc musl-dev openssh && \
    pip install --upgrade pip && pip install packaging azure apache-libcloud pycrypto && \
    apk add --update unzip && \
    wget https://releases.hashicorp.com/terraform/0.11.11/terraform_0.11.11_linux_amd64.zip && \
    unzip terraform_0.11.11_linux_amd64.zip -d terraform_bin && \
    mv ./terraform_bin/terraform /usr/local/bin/terraform && \
    rm -rf terraform_0.11.11_linux_amd64.zip ./terraform_bin && \
    wget https://releases.hashicorp.com/consul/1.5.0/consul_1.5.0_linux_amd64.zip && \
    unzip consul_1.5.0_linux_amd64.zip && \
    rm consul_1.5.0_linux_amd64.zip && \
    mv ./consul /usr/local/bin/ && \
    mkdir ~/.ssh && \
    echo "Host *" > ~/.ssh/config && \
    echo "  StrictHostKeyChecking no" >> ~/.ssh/config
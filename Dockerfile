FROM ubuntu:20.04

WORKDIR /workspace

# apt-get时无需等待用户输入
ARG DEBIAN_FRONTEND=noninteractive
# 更换国内阿里云源
COPY ./material/sources.list /etc/apt/sources.list

# apt-utils, gnupg2, lsb-release, software-properties-common: 后续命令的依赖
# build-essential: 包括gcc-9, g++-9, make, libc6-dev, dpkg-dev
# ssh, openssh-server, openssl, rsync: clion remote使用
RUN apt-get update \
    && apt-get install -y --no-install-recommends\
        apt-utils \
        build-essential \ 
        cmake \
        curl \
        gdb \
        gdbserver \
        git \
        gnupg2 \
        libboost-dev \
        libssl-dev \
        lsb-release \
        openssh-server \
        openssl \
        python3 \
        python3-pip \
        rsync \
        software-properties-common \
        ssh \
        sudo \
        wget \
    && apt-get autoremove --purge -y \
    && apt-get autoclean -y \
    && rm -rf /var/cache/apt/*

# install llvm clang/++ lldb

# ARG LLVM_VERSION=11
# COPY ./llvm.sh llvm.sh
# RUN chmod +x llvm.sh \
#     && ./llvm.sh ${LLVM_VERSION}

ARG user=ubuntu \
    passwd=ubuntu \
    uid=1588 \
    gid=1588 \
    home_dir=/home/ubuntu

RUN groupadd -g ${gid} ${user} \
    && useradd --create-home --home-dir ${home_dir} --shell /bin/bash --gid ${gid} --uid ${uid} --groups sudo --password ${passwd} --no-log-init ${user} \
    && echo 'ubuntu ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers \
    && chmod 644 /etc/sudoers

# install miniconda
RUN wget \
    https://mirrors.sjtug.sjtu.edu.cn/anaconda/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    # https://mirrors.bfsu.edu.cn/anaconda/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    # https://mirrors.tuna.tsinghua.edu.cn/anaconda/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    # https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && bash Miniconda3-latest-Linux-x86_64.sh -b -p /usr/local/miniconda3 \
    && rm -f Miniconda3-latest-Linux-x86_64.sh \
    && groupadd miniconda \
    && chgrp -R miniconda /usr/local/miniconda3 \
    && chmod 770 -R /usr/local/miniconda3 \
    && usermod -a -G miniconda ${user} \
    && chmod g+s /usr/local/miniconda3 \
    && find /usr/local/miniconda3 -type d | xargs -i chmod g+s {} \
    && chmod g-w /usr/local/miniconda3/envs 
    # && echo "export PATH=/usr/local/miniconda3/bin:$PATH" >> /etc/profile

ENV PATH=/usr/local/miniconda3/bin:$PATH

USER ${user}

WORKDIR ${home_dir}

COPY ./material/.condarc .condarc

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]

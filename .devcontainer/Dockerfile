ARG PYTHON_VER=3.7.0
# https://pytorch.org/get-started/previous-versions/
# CUDA 11.1
# pip install torch==1.9.0+cu111 torchvision==0.10.0+cu111 torchaudio==0.9.0 -f https://download.pytorch.org/whl/torch_stable.html
ARG TORCH_VER=1.9.0
ARG TORCH_VISON_VER=0.10.0
ARG CUDA_VER=11.1.1
ARG UBUNTU_VER=20.04

# check whether the base image exists in dockerhub repo
# https://hub.docker.com/r/nvidia/cuda
FROM nvidia/cuda:${CUDA_VER}-base-ubuntu${UBUNTU_VER}

# https://freak-da.hatenablog.com/entry/2020/03/31/094140
ARG PYTHON_VER_NO_PERIODS=37
ARG PYTHON_VER
ARG TORCH_VER
ARG TORCH_VISON_VER
ARG CUDA_VER_NO_PERIODS=111
ARG UBUNTU_VER
ARG DEBIAN_FRONTEND=noninteractive

ENV WORK_DIR /app
WORKDIR ${WORK_DIR}

ARG TZ=Asia/Tokyo
RUN ln -snf /usr/share/zoneinfo/${TZ} /etc/localtime && echo ${TZ} > /etc/timezone

# Install some basic utilities
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    sudo \
    wget \
    curl \
    vim \
    git \
    bzip2 \
    build-essential \
    vim \
    libgl1-mesa-glx \
    libglib2.0-0 \
    zlib1g-dev \
    libffi-dev \
    libssl-dev \
    python3-pip \
    python3-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install Python 
RUN wget https://www.python.org/ftp/python/$PYTHON_VER/Python-$PYTHON_VER.tgz \
    &&  tar -xf Python-$PYTHON_VER.tgz \
    &&  cd Python-$PYTHON_VER \
    &&  ./configure --enable-optimizations \
    &&  make -j $(nproc) \
    &&  make altinstall

# Install pip packages
# RUN ln -s /usr/bin/python3 /usr/bin/python \
#     &&  pip install --upgrade pip \
#     &&  pip install torch==${TORCH_VER}+cu${CUDA_VER_NO_PERIODS} torchvision==${TORCH_VISON_VER}+cu${CUDA_VER_NO_PERIODS} --index-url https://download.pytorch.org/whl/cu${CUDA_VER_NO_PERIODS} \
#     &&  pip install opencv-python numpy tqdm ninja mediapipe
    # torch-2.0.1+cu117.with.pypi.cudnn-cp310-cp310-linux_x86_64.whl
    # pip install torch==${TORCH_VER}+cu${CUDA_VER_NO_PERIODS} torchvision==0.15.1+cu{CUDA_VER_NO_PERIODS} --index-url https://download.pytorch.org/whl/cu117 \
    # pip install torch torchvision \

# # requirements.txtの場合
COPY requirements.txt ${WORK_DIR}
# COPY requirements.txt /
# # COPY environment.yml ${WORK_DIR}

# # https://qiita.com/Sicut_study/items/b612174caab6d0e2c9bf
# ARG CRYPTOGRAPHY_DONT_BUILD_RUST=1


RUN ln -s /usr/bin/python3 /usr/bin/python \
    &&  pip3 install --upgrade pip setuptools wheel \
    &&  pip3 install --no-cache-dir cmake \
    &&  pip3 install --no-cache-dir -r requirements.txt
    # &&  pip install cryptacular \

#  Install some basic utilities
RUN apt-get update && apt-get install -y --no-install-recommends \
    x11-apps \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*


# # Create a working directory
# RUN mkdir ${WORK_DIR}
# WORKDIR ${WORK_DIR}

# # this is heavy if your current folder is a big data storage
# # COPY . ${WORK_DIR}

# # # Install Miniconda and Python 3.x
# # ENV CONDA_AUTO_UPDATE_CONDA=false
# # ENV PATH=/home/user/miniconda/bin:$PATH
# # RUN curl -sLo ~/miniconda.sh https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh \
# #  && chmod +x ~/miniconda.sh \
# #  && ~/miniconda.sh -b -p ~/miniconda \
# #  && rm ~/miniconda.sh \
# #  && conda install -y python==$PYTHON_VERSION numpy scipy pandas matplotlib tqdm \
# #  && conda clean -ya


# # https://qiita.com/junkor-1011/items/cd7c0e626aedc335011d
# # ローカルuser作成
# # ARG USER_NAME=user
# # ARG USER_UID=1000
# # ARG PASSWD=password
# # RUN useradd -m -s /bin/bash -u ${USER_UID} ${USER_NAME} && \
# #     gpasswd -a ${USER_NAME} sudo && \
# #     echo "${USER_NAME}:${PASSWD}" | chpasswd && \
# #     echo "${USER_NAME} ALL=(ALL) ALL" >> /etc/sudoers && \
# #     chmod g+w /etc/passwd


# # conda用準備
# ENV CONDA_DIR=/opt/conda \
#     CONDA_TMP_DIR=/tmp/conda \
#     HOME=/home/$USER_NAME \
#     SHELL=/bin/bash
# RUN mkdir -p $CONDA_DIR && \
#     mkdir -p $CONDA_TMP_DIR
#     # && \
#     # chown $USER_NAME:$USER_UID $CONDA_DIR && \
#     # chown $USER_NAME:$USER_UID $CONDA_TMP_DIR

# # yamlファイルの取り込み
# ARG CONDA_YAML="./environment.yml"
# COPY $CONDA_YAML /tmp/conda_packages.yml

# # USER ${USER_NAME}

# # WORKDIR $HOME

# # miniconda
# # https://repo.anaconda.com/miniconda/
# ARG MINICONDA_VERSION=py${PYTHON_VER_NO_PERIODS}_23.3.1-0-Linux-x86_64
# # latest-Linux-x86_64
# # py37_4.8.3-Linux-x86_64
# # ARG MINICONDA_MD5=751786b92c00b1aeae3f017b781018df
# ENV PATH=${CONDA_DIR}/bin:$PATH

# RUN cd /tmp && \
#     wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-${MINICONDA_VERSION}.sh && \
#     /bin/bash Miniconda3-${MINICONDA_VERSION}.sh -f -b -p $CONDA_TMP_DIR && \
#     rm Miniconda3-${MINICONDA_VERSION}.sh && \
#     $CONDA_TMP_DIR/bin/conda env create -f /tmp/conda_packages.yml -p $CONDA_DIR && \
#     rm -rf $HOME/.cache/* && \
#     rm -rf $CONDA_TMP_DIR/*
#     # echo "${MINICONDA_MD5} *Miniconda3-${MINICONDA_VERSION}.sh" | md5sum -c - && \
#     # 


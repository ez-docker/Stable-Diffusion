FROM nvidia/cuda:12.1.0-base-ubuntu20.04

# 设置时区
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo "Asia/Shanghai" > /etc/timezone

# 替换Ubuntu 20.04系统源为阿里源
RUN echo "deb http://mirrors.aliyun.com/ubuntu/ focal main restricted universe multiverse" > /etc/apt/sources.list \
    && echo "deb http://mirrors.aliyun.com/ubuntu/ focal-security main restricted universe multiverse" >> /etc/apt/sources.list \
    && echo "deb http://mirrors.aliyun.com/ubuntu/ focal-updates main restricted universe multiverse" >> /etc/apt/sources.list \
    && echo "deb http://mirrors.aliyun.com/ubuntu/ focal-backports main restricted universe multiverse" >> /etc/apt/sources.list \
    && echo "deb http://mirrors.aliyun.com/ubuntu/ focal-proposed main restricted universe multiverse" >> /etc/apt/sources.list \
    && apt-get update && apt-get -y install curl wget git


# 安装 Miniconda
# RUN curl -sLo /tmp/miniconda.sh https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
ENV CONDA_AUTO_UPDATE_CONDA=false
RUN curl -sLo /tmp/miniconda.sh https://mirrors.ustc.edu.cn/anaconda/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
    chmod +x /tmp/miniconda.sh && \
    /tmp/miniconda.sh -b -p /opt/miniconda && \
    rm -f /tmp/miniconda.sh && \
    ln -s /opt/miniconda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/miniconda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "/opt/miniconda/bin/activate" >> ~/.bashrc && \
    source ~/.bashrc


# 创建名为sd的环境
RUN /opt/miniconda/bin/conda create -n sd python=3.10.6
RUN echo "source activate sd" > ~/.bashrc
ENV PATH /opt/conda/envs/sd/bin:$PATH








# 运行命令
CMD ["/bin/sh"]

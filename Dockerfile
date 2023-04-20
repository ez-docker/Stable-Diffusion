FROM nvidia/cuda:12.1.0-base-ubuntu20.04
ENV CONDA_AUTO_UPDATE_CONDA=false

RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo "Asia/Shanghai" > /etc/timezone && \
    apt-get update && apt-get -y install curl wget git && \
    curl -sLo /tmp/miniconda.sh https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
    chmod +x /tmp/miniconda.sh && \
    /tmp/miniconda.sh -b -p /opt/miniconda && \
    rm -f /tmp/miniconda.sh && \
    ln -s /opt/miniconda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/miniconda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "/opt/miniconda/bin/activate" >> ~/.bashrc && \
    source ~/.bashrc && \
    RUN /opt/miniconda/bin/conda create -n sd python=3.10.6 && \
    echo "source activate sd" > ~/.bashrc && \
ENV PATH /opt/conda/envs/sd/bin:$PATH

CMD ["/bin/sh"]

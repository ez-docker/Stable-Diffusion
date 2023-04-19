FROM python:3.10-alpine3.17

RUN apk update && apk upgrade && \
    apk add --no-cache \
        bash \
        curl \
        git \
        gcc \
        build-base \
        libressl-dev \
        libffi-dev \
        libxml2-dev \
        libxslt-dev \
        libjpeg-turbo-dev \
        openblas-dev \
        opencv-dev && \
    apk add --no-cache ffmpeg && \
    pip install torch torchvision torchaudio --no-cache-dir && \
    pip install ftfy regex tqdm omegaconf requests && \
    pip install basicsr clip && \
    apk del build-base && \
    rm -rf /var/cache/apk/*

WORKDIR /app

CMD ["/bin/bash"]

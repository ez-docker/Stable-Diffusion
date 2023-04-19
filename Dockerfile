FROM python:3.10-alpine3.17

RUN apk update && apk upgrade

RUN apk add --no-cache \
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
        ffmpeg
RUN pip install torch torchvision torchaudio --no-cache-dir
RUN pip install ftfy regex tqdm omegaconf requests --no-cache-dir
RUN pip install basicsr clip --no-cache-dir && \
    apk del build-base && \
    rm -rf /var/cache/apk/*

WORKDIR /app

CMD ["/bin/bash"]

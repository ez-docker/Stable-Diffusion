FROM python:3.10-alpine3.17
RUN apk --no-cache add \
    bash \
    curl \
    git \
    gcc
# 安装 pytorch
RUN pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu

# 安装 GFPGAN
RUN pip install basicsr clip

CMD ["/bin/bash"]

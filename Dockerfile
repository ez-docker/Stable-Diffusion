# docker build -t sd .
# docker run -it --name sd sd
# docker rm -f sd

FROM python:3.10-alpine3.17


RUN apk update && apk upgrade && \
	apk add --no-cache \
        bash \
        curl \
        git \
        wget

RUN pip install --upgrade pip && \
	pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu

RUN cd / && git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git && \
	mv \stable-diffusion-webui \app && cd /app
RUN pip install blendmodes==2022
RUN pip install transformers==4.25.1
RUN pip install accelerate==0.12.0
RUN pip install basicsr==1.4.2
RUN pip install gfpgan==1.3.8
RUN pip install gradio==3.23
RUN pip install numpy==1.23.3
RUN pip install Pillow==9.4.0
RUN pip install realesrgan==0.3.0
RUN pip install torch
RUN pip install omegaconf==2.2.3
RUN pip install pytorch_lightning==1.9.4
RUN pip install scikit-image==0.19.2
RUN pip install fonts
RUN pip install font-roboto
RUN pip install timm==0.6.7
RUN pip install piexif==1.1.3
RUN pip install einops==0.4.1
RUN pip install jsonmerge==1.8.0
RUN pip install clean-fid==0.1.29
RUN pip install resize-right==0.0.2
RUN pip install torchdiffeq==0.2.3
RUN pip install kornia==0.6.7
RUN pip install lark==1.1.2
RUN pip install inflection==0.5.1
RUN pip install GitPython==3.1.30
RUN pip install torchsde==0.2.5
RUN pip install safetensors==0.3.0
RUN pip install httpcore<=0.15
RUN pip install fastapi==0.94.0

RUN pip install -r requirements_versions.txt
RUN export COMMANDLINE_ARGS=--skip-torch-cuda-test
RUN python launch.py

# RUN cd / && git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git && \
# 	mv \stable-diffusion-webui \app && cd /app && \
# 	pip install -r requirements_versions.txt && \
# 	cd models/Stable-diffusion && \
# 	wget https://huggingface.co/CompVis/stable-diffusion-v-1-4-original/resolve/main/sd-v1-4-full-ema.ckpt && \
# 	wget -O launch.py https://raw.githubusercontent.com/eclairkk/Stable-Diffusion/master/launch_cpu.py && \
# 	export COMMANDLINE_ARGS=--skip-torch-cuda-test && \
#	python launch.py


WORKDIR /app
CMD [ "python", "launch.py", "--no-half", "--port", "1234", "--listen" ]

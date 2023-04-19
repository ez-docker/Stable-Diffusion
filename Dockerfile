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

RUN pip install GFPGAN

RUN cd / && git clone https://github.com/openai/CLIP.git@d50d76daa670286dd6cacf3bcd80b5e4823fc8e1 && \
	cd /CLIP && \
	pip install -r requirements.txt && \
	pip install .

RUN cd / && git clone https://github.com/mlfoundations/open_clip.git@bb6e834e9c70d9c27d0dc3ecedeebeaeb1ffad6b && \
	cd /open_clip && \
	pip install -r requirements.txt && \
	pip install .

RUN cd / && git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git && \
 	mv \stable-diffusion-webui \app && cd /app && \
 	pip install -r requirements_versions.txt && \
# 	cd models/Stable-diffusion && \
# 	wget https://huggingface.co/CompVis/stable-diffusion-v-1-4-original/resolve/main/sd-v1-4-full-ema.ckpt && \
 	wget -O launch.py https://raw.githubusercontent.com/eclairkk/Stable-Diffusion/master/launch_cpu.py && \
 	export COMMANDLINE_ARGS=--skip-torch-cuda-test


		


WORKDIR /app
CMD [ "python", "launch.py", "--no-half", "--port", "1234", "--listen" ]

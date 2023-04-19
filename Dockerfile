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

RUN git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git && \
	mv \stable-diffusion-webui \app
		
# RUN git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git && \
        # mv stable-diffusion-webui /app && \
        # cd /app && \
        # pip install -r requirements_versions.txt && \
        # cd models/Stable-diffusion && \
        # wget https://huggingface.co/CompVis/stable-diffusion-v-1-4-original/resolve/main/sd-v1-4-full-ema.ckpt && \
        # export COMMANDLINE_ARGS=--skip-torch-cuda-test

WORKDIR /app
CMD [ "python", "launch.py", "--no-half", "--port", "1234", "--listen" ]

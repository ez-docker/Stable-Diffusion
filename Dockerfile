FROM python:3.10-alpine3.17

RUN apk update && apk upgrade

RUN apk add --no-cache \
        bash \
        curl \
        git \
        wget \
        unzip

WORKDIR /app
RUN cd /app \
        && wget https://github.com/cmdr2/stable-diffusion-ui/releases/download/v2.5.24/Easy-Diffusion-Linux.zip \
        && unzip Easy-Diffusion-Linux.zip \
        && cd /app/easy-diffusion \
        && chmod +x start.sh \
        && chmod +x /app/easy-diffusion/scripts/bootstrap.sh \
        && chmod +x /app/easy-diffusion/scripts/functions.sh \
        && chmod +x /app/easy-diffusion/scripts/on_env_start.sh \
        && bash start.sh
        

CMD ["/bin/bash"]

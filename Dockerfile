# docker build -t sd .
# docker run --name sd -it sd
# docker rm -f sd
FROM nvidia/cuda:12.1.0-base-ubuntu20.04


RUN apt-get update && apt-get install -y curl wget unzip git
RUN wget -O /tmp/Easy-Diffusion-Linux.zip https://github.com/cmdr2/stable-diffusion-ui/releases/download/v2.5.24/Easy-Diffusion-Linux.zip
RUN unzip /tmp/Easy-Diffusion-Linux.zip -d /
RUN mv /easy-diffusion/ /sd
RUN chmod +x sd/*.sh
RUN chmod +x sd/scripts/*.sh
bash /sd/start.sh

CMD ["/bin/sh"]

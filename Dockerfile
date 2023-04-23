FROM mambaorg/micromamba:focal-cuda-12.1.0

RUN micromamba install --yes --name base --channel conda-forge \
    python=3.10.6 \
    uvicorn=0.21.1 \
    fastapi=0.95.1 && \
    micromamba clean --all --yes

ARG MAMBA_DOCKERFILE_ACTIVATE=1
RUN micromamba run pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu && \
    micromamba run pip install sdkit

CMD ["/bin/bash"]

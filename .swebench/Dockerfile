FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    git build-essential libffi-dev libssl-dev curl wget ca-certificates \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN wget -q https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-x86_64.sh -O /tmp/miniforge.sh && \
    bash /tmp/miniforge.sh -b -p /opt/conda && \
    rm /tmp/miniforge.sh

ENV PATH="/opt/conda/bin:$PATH"

RUN conda init bash

COPY .swebench/environment.yml /tmp/environment.yml
RUN conda env create --file /tmp/environment.yml && \
    conda clean -afy && \
    rm /tmp/environment.yml

# Clone repo at /app
RUN mkdir -p /app
WORKDIR /app
RUN git clone --depth 1 https://github.com/mwaskom/seaborn.git . && \
    git fetch --depth 1 origin d25872b0fc99dbf7e666a91f59bd4ed125186aa1 && \
    git checkout d25872b0fc99dbf7e666a91f59bd4ed125186aa1 && \
    git fetch --depth 1 origin 22cdfb0c93f8ec78492d87edb810f10cb7f57a31

# Reset to base commit BEFORE install (so .so files match BASE_COMMIT code)
RUN git checkout 22cdfb0c93f8ec78492d87edb810f10cb7f57a31

# Install repo (exact commands from original workflow)
SHELL ["/bin/bash", "-c"]
RUN source activate testbed && \
    export SETUPTOOLS_SCM_PRETEND_VERSION=0.0.0 && \
    python -m pip install -e .[dev]


CMD ["bash"]

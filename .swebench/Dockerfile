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
RUN git clone --depth 1 https://github.com/astropy/astropy.git . && \
    git fetch --depth 1 origin 2e89d074b3b2abc2da80e437c93b1d5516a0ca57 && \
    git checkout 2e89d074b3b2abc2da80e437c93b1d5516a0ca57 && \
    git fetch --depth 1 origin b750a0e6ee76fb6b8a099a4d16ec51977be46bf6

# Reset to base commit BEFORE install (so .so files match BASE_COMMIT code)
RUN git checkout b750a0e6ee76fb6b8a099a4d16ec51977be46bf6

# Install repo (exact commands from original workflow)
SHELL ["/bin/bash", "-c"]
RUN source activate testbed && \
    export SETUPTOOLS_SCM_PRETEND_VERSION=99.0.0 && \
    python -m pip install -e .[test] --verbose


CMD ["bash"]

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
    git fetch --depth 1 origin 5f74eacbcc7fff707a44d8eb58adaa514cb7dcb5 && \
    git checkout 5f74eacbcc7fff707a44d8eb58adaa514cb7dcb5 && \
    git fetch --depth 1 origin cdb66059a2feb44ee49021874605ba90801f9986

# Reset to base commit BEFORE install (so .so files match BASE_COMMIT code)
RUN git checkout cdb66059a2feb44ee49021874605ba90801f9986

# Install repo (exact commands from original workflow)
SHELL ["/bin/bash", "-c"]
RUN source activate testbed && \
    sed -i 's/requires = \["setuptools",/requires = \["setuptools==68.0.0",/' pyproject.toml && \
    export SETUPTOOLS_SCM_PRETEND_VERSION=99.0.0 && \
    python -m pip install -e .[test] --verbose


CMD ["bash"]

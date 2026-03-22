FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    git build-essential libffi-dev libssl-dev libpng-dev libfreetype-dev \
    pkg-config curl wget ca-certificates \
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

# Clone repo and install at /app
RUN mkdir -p /app
WORKDIR /app
RUN git clone --depth 1 https://github.com/scikit-learn/scikit-learn.git . && \
    git fetch --depth 1 origin 1e8a5b833d1b58f3ab84099c4582239af854b23a && \
    git checkout 1e8a5b833d1b58f3ab84099c4582239af854b23a

# Install repo (compiles C extensions once)
SHELL ["/bin/bash", "-c"]
RUN source activate testbed && \
    export SETUPTOOLS_SCM_PRETEND_VERSION=0.0.0 && \
    python -m pip install -v --no-use-pep517 --no-build-isolation -e .

# Reset to base commit
RUN git checkout 10dbc142bd17ccf7bd38eec2ac04b52ce0d1009e || true

CMD ["bash"]

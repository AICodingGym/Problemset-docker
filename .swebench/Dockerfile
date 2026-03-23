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
RUN git clone --depth 1 https://github.com/psf/requests.git . && \
    git fetch --depth 1 origin ba25184ed5f0bf9b876dea3cf4312fa35b539a7c && \
    git checkout ba25184ed5f0bf9b876dea3cf4312fa35b539a7c && \
    git fetch --depth 1 origin 22623bd8c265b78b161542663ee980738441c307

# Reset to base commit BEFORE install (so .so files match BASE_COMMIT code)
RUN git checkout 22623bd8c265b78b161542663ee980738441c307

# Install repo (exact commands from original workflow)
SHELL ["/bin/bash", "-c"]
RUN source activate testbed && \
    python -m pip install .


CMD ["bash"]

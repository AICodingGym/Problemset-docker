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
    git fetch --depth 1 origin bbeb0001cdc657ac8c7fef98e154229bc392db0e && \
    git checkout bbeb0001cdc657ac8c7fef98e154229bc392db0e && \
    git fetch --depth 1 origin 5f7a3a74aab1625c2bb65f643197ee885e3da576

# Reset to base commit BEFORE install (so .so files match BASE_COMMIT code)
RUN git checkout 5f7a3a74aab1625c2bb65f643197ee885e3da576

# Install repo (exact commands from original workflow)
SHELL ["/bin/bash", "-c"]
RUN source activate testbed && \
    python -m pip install .


CMD ["bash"]

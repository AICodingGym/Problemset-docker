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
RUN git clone --depth 1 https://github.com/pylint-dev/pylint.git . && \
    git fetch --depth 1 origin a0ce6e424e3a208f3aed1cbf6e16c40853bec3c0 && \
    git checkout a0ce6e424e3a208f3aed1cbf6e16c40853bec3c0 && \
    git fetch --depth 1 origin 1f8c4d9eb185c16a2c1d881c054f015e1c2eb334

# Reset to base commit BEFORE install (so .so files match BASE_COMMIT code)
RUN git checkout 1f8c4d9eb185c16a2c1d881c054f015e1c2eb334

# Install repo (exact commands from original workflow)
SHELL ["/bin/bash", "-c"]
RUN source activate testbed && \
    export SETUPTOOLS_SCM_PRETEND_VERSION=99.0.0 && \
    python -m pip install -e .


CMD ["bash"]

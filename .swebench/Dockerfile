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
RUN git clone --depth 1 https://github.com/pytest-dev/pytest.git . && \
    git fetch --depth 1 origin 634cde9506eb1f48dec3ec77974ee8dc952207c6 && \
    git checkout 634cde9506eb1f48dec3ec77974ee8dc952207c6 && \
    git fetch --depth 1 origin 422685d0bdc110547535036c1ff398b5e1c44145

# Reset to base commit BEFORE install (so .so files match BASE_COMMIT code)
RUN git checkout 422685d0bdc110547535036c1ff398b5e1c44145

# Install repo (exact commands from original workflow)
SHELL ["/bin/bash", "-c"]
RUN source activate testbed && \
    export SETUPTOOLS_SCM_PRETEND_VERSION="6.0.0" && \
    export SETUPTOOLS_SCM_PRETEND_VERSION=99.0.0 && \
    python -m pip install -e .


CMD ["bash"]

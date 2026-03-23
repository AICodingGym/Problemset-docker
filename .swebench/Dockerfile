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
RUN git clone --depth 1 https://github.com/scikit-learn/scikit-learn.git . && \
    git fetch --depth 1 origin 7e85a6d1f038bbb932b36f18d75df6be937ed00d && \
    git checkout 7e85a6d1f038bbb932b36f18d75df6be937ed00d && \
    git fetch --depth 1 origin 6ab8c86c383dd847a1be7103ad115f174fe23ffd

# Reset to base commit BEFORE install (so .so files match BASE_COMMIT code)
RUN git checkout 6ab8c86c383dd847a1be7103ad115f174fe23ffd

# Install repo (exact commands from original workflow)
SHELL ["/bin/bash", "-c"]
RUN source activate testbed && \
    export SETUPTOOLS_SCM_PRETEND_VERSION=99.0.0 && \
    python -m pip install -v --no-use-pep517 --no-build-isolation -e .


CMD ["bash"]

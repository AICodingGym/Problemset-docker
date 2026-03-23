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
RUN git clone --depth 1 https://github.com/sympy/sympy.git . && \
    git fetch --depth 1 origin 73b3f90093754c5ed1561bd885242330e3583004 && \
    git checkout 73b3f90093754c5ed1561bd885242330e3583004 && \
    git fetch --depth 1 origin 5e17a90c19f7eecfa10c1ab872648ae7e2131323

# Reset to base commit BEFORE install (so .so files match BASE_COMMIT code)
RUN git checkout 5e17a90c19f7eecfa10c1ab872648ae7e2131323

# Install repo (exact commands from original workflow)
SHELL ["/bin/bash", "-c"]
RUN source activate testbed && \
    export SETUPTOOLS_SCM_PRETEND_VERSION=99.0.0 && \
    python -m pip install -e .


CMD ["bash"]

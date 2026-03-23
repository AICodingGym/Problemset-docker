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
RUN git clone --depth 1 https://github.com/pallets/flask.git . && \
    git fetch --depth 1 origin 182ce3dd15dfa3537391c3efaf9c3ff407d134d4 && \
    git checkout 182ce3dd15dfa3537391c3efaf9c3ff407d134d4 && \
    git fetch --depth 1 origin 7ee9ceb71e868944a46e1ff00b506772a53a4f1d

# Reset to base commit BEFORE install (so .so files match BASE_COMMIT code)
RUN git checkout 7ee9ceb71e868944a46e1ff00b506772a53a4f1d

# Install repo (exact commands from original workflow)
SHELL ["/bin/bash", "-c"]
RUN source activate testbed && \
    export SETUPTOOLS_SCM_PRETEND_VERSION=0.0.0 && \
    python -m pip install -e .


CMD ["bash"]

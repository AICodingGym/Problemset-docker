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
    git fetch --depth 1 origin a1a6a549a0143d9b32717dbe3d75cd543ae5a4f6 && \
    git checkout a1a6a549a0143d9b32717dbe3d75cd543ae5a4f6 && \
    git fetch --depth 1 origin 39d0fdd9096f7dceccbc8f82e1eda7dd64717a8e

# Reset to base commit BEFORE install (so .so files match BASE_COMMIT code)
RUN git checkout 39d0fdd9096f7dceccbc8f82e1eda7dd64717a8e

# Install repo (exact commands from original workflow)
SHELL ["/bin/bash", "-c"]
RUN source activate testbed && \
    python -m pip install .


CMD ["bash"]

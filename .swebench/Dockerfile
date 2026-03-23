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
RUN git clone --depth 1 https://github.com/sphinx-doc/sphinx.git . && \
    git fetch --depth 1 origin 89808c6f49e1738765d18309244dca0156ee28f6 && \
    git checkout 89808c6f49e1738765d18309244dca0156ee28f6 && \
    git fetch --depth 1 origin 71db08c05197545944949d5aa76cd340e7143627

# Reset to base commit BEFORE install (so .so files match BASE_COMMIT code)
RUN git checkout 71db08c05197545944949d5aa76cd340e7143627

# Install repo (exact commands from original workflow)
SHELL ["/bin/bash", "-c"]
RUN source activate testbed && \
    sed -i 's/pytest/pytest -rA/' tox.ini && \
    export SETUPTOOLS_SCM_PRETEND_VERSION=99.0.0 && \
    python -m pip install -e .[test]


CMD ["bash"]

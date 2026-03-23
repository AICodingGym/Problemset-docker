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
RUN git clone --depth 1 https://github.com/matplotlib/matplotlib.git . && \
    git fetch --depth 1 origin f93c0a3dcb82feed0262d758626c90d4002685f3 && \
    git checkout f93c0a3dcb82feed0262d758626c90d4002685f3 && \
    git fetch --depth 1 origin f0632c0fc7339f68e992ed63ae4cfac76cd41aad

# Reset to base commit BEFORE install (so .so files match BASE_COMMIT code)
RUN git checkout f0632c0fc7339f68e992ed63ae4cfac76cd41aad

# Install repo (exact commands from original workflow)
SHELL ["/bin/bash", "-c"]
RUN source activate testbed && \
    apt-get -y update && apt-get -y upgrade && DEBIAN_FRONTEND=noninteractive apt-get install -y imagemagick ffmpeg libfreetype6-dev pkg-config texlive texlive-latex-extra texlive-fonts-recommended texlive-xetex texlive-luatex cm-super && \
    QHULL_URL="http://www.qhull.org/download/qhull-2020-src-8.0.2.tgz" && \
    QHULL_TAR="/tmp/qhull-2020-src-8.0.2.tgz" && \
    QHULL_BUILD_DIR="/app/build" && \
    wget -O "$QHULL_TAR" "$QHULL_URL" && \
    mkdir -p "$QHULL_BUILD_DIR" && \
    tar -xvzf "$QHULL_TAR" -C "$QHULL_BUILD_DIR" && \
    export SETUPTOOLS_SCM_PRETEND_VERSION=99.0.0 && \
    python -m pip install -e .


CMD ["bash"]

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
RUN git clone --depth 1 https://github.com/django/django.git . && \
    git fetch --depth 1 origin 4fc35a9c3efdc9154efce28cb23cb84f8834517e && \
    git checkout 4fc35a9c3efdc9154efce28cb23cb84f8834517e && \
    git fetch --depth 1 origin b9cf764be62e77b4777b3a75ec256f6209a57671

# Reset to base commit BEFORE install (so .so files match BASE_COMMIT code)
RUN git checkout b9cf764be62e77b4777b3a75ec256f6209a57671

# Install repo (exact commands from original workflow)
SHELL ["/bin/bash", "-c"]
RUN source activate testbed && \
    apt-get update && apt-get install -y locales && \
    bash -c 'echo '"'"'en_US UTF-8'"'"' > /etc/locale.gen' && \
    locale-gen en_US.UTF-8 && \
    python setup.py install && \
    export SETUPTOOLS_SCM_PRETEND_VERSION=99.0.0 && \
    python -m pip install -e .


CMD ["bash"]

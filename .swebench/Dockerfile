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
    git fetch --depth 1 origin 3b85187ffa3401e88582073c23188c147857a8a3 && \
    git checkout 3b85187ffa3401e88582073c23188c147857a8a3 && \
    git fetch --depth 1 origin 1e2ccd8f0eca0870cf6f8fce6934e2da8eba9b72

# Reset to base commit BEFORE install (so .so files match BASE_COMMIT code)
RUN git checkout 1e2ccd8f0eca0870cf6f8fce6934e2da8eba9b72

# Install repo (exact commands from original workflow)
SHELL ["/bin/bash", "-c"]
RUN source activate testbed && \
    sed -i 's/pytest/pytest -rA/' tox.ini && \
    sed -i 's/Jinja2>=2.3/Jinja2<3.0/' setup.py && \
    sed -i 's/sphinxcontrib-applehelp/sphinxcontrib-applehelp<=1.0.7/' setup.py && \
    sed -i 's/sphinxcontrib-devhelp/sphinxcontrib-devhelp<=1.0.5/' setup.py && \
    sed -i 's/sphinxcontrib-qthelp/sphinxcontrib-qthelp<=1.0.6/' setup.py && \
    sed -i 's/alabaster>=0.7,<0.8/alabaster>=0.7,<0.7.12/' setup.py && \
    sed -i "s/'packaging',/'packaging', 'markupsafe<=2.0.1',/" setup.py && \
    sed -i 's/sphinxcontrib-htmlhelp/sphinxcontrib-htmlhelp<=2.0.4/' setup.py && \
    sed -i 's/sphinxcontrib-serializinghtml/sphinxcontrib-serializinghtml<=1.1.9/' setup.py && \
    export SETUPTOOLS_SCM_PRETEND_VERSION=99.0.0 && \
    python -m pip install -e .[test]


CMD ["bash"]

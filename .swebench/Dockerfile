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
    git fetch --depth 1 origin 5afc77ee27fc01c57165ab260d3a76751f9ddb35 && \
    git checkout 5afc77ee27fc01c57165ab260d3a76751f9ddb35 && \
    git fetch --depth 1 origin b3e26a6c851133b82b50f4b68b53692076574d13

# Reset to base commit BEFORE install (so .so files match BASE_COMMIT code)
RUN git checkout b3e26a6c851133b82b50f4b68b53692076574d13

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

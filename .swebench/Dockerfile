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
    git fetch --depth 1 origin 9a2c3c4a1559e37e95fdee88c128bb116642c897 && \
    git checkout 9a2c3c4a1559e37e95fdee88c128bb116642c897 && \
    git fetch --depth 1 origin 6918e69600810a4664e53653d6ff0290c3c4a788

# Reset to base commit BEFORE install (so .so files match BASE_COMMIT code)
RUN git checkout 6918e69600810a4664e53653d6ff0290c3c4a788

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
    grep -q 'sphinxcontrib-htmlhelp>=2.0.0' setup.py && sed -i 's/sphinxcontrib-htmlhelp>=2.0.0/sphinxcontrib-htmlhelp>=2.0.0,<=2.0.4/' setup.py || sed -i 's/sphinxcontrib-htmlhelp/sphinxcontrib-htmlhelp<=2.0.4/' setup.py && \
    grep -q 'sphinxcontrib-serializinghtml>=1.1.5' setup.py && sed -i 's/sphinxcontrib-serializinghtml>=1.1.5/sphinxcontrib-serializinghtml>=1.1.5,<=1.1.9/' setup.py || sed -i 's/sphinxcontrib-serializinghtml/sphinxcontrib-serializinghtml<=1.1.9/' setup.py && \
    export SETUPTOOLS_SCM_PRETEND_VERSION=99.0.0 && \
    python -m pip install -e .[test]


CMD ["bash"]

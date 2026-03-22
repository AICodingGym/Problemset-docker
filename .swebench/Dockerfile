FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y     git build-essential libffi-dev libssl-dev curl wget ca-certificates     && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN wget -q https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-x86_64.sh -O /tmp/miniforge.sh &&     bash /tmp/miniforge.sh -b -p /opt/conda &&     rm /tmp/miniforge.sh

ENV PATH="/opt/conda/bin:$PATH"

RUN conda init bash

COPY .swebench/environment.yml /tmp/environment.yml
RUN conda env create --file /tmp/environment.yml &&     conda clean -afy &&     rm /tmp/environment.yml

CMD ["bash"]

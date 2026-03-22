FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y     git build-essential libffi-dev libssl-dev curl wget ca-certificates     && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN wget -q https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /tmp/miniconda.sh &&     bash /tmp/miniconda.sh -b -p /opt/conda &&     rm /tmp/miniconda.sh

ENV PATH="/opt/conda/bin:$PATH"

RUN conda init bash && conda config --add channels conda-forge &&     conda tos accept --override-channels --channel https://repo.anaconda.com/pkgs/main &&     conda tos accept --override-channels --channel https://repo.anaconda.com/pkgs/r

COPY .swebench/environment.yml /tmp/environment.yml
RUN conda env create --file /tmp/environment.yml &&     conda clean -afy &&     rm /tmp/environment.yml

CMD ["bash"]

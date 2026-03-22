FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# System dependencies (matches GHA ubuntu-22.04 runner)
RUN apt-get update && apt-get install -y \
    git build-essential libffi-dev libssl-dev curl wget ca-certificates \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Miniconda (same as conda-incubator/setup-miniconda on GHA)
RUN wget -q https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /tmp/miniconda.sh && \
    bash /tmp/miniconda.sh -b -p /opt/conda && \
    rm /tmp/miniconda.sh
ENV PATH="/opt/conda/bin:$PATH"
RUN conda init bash && conda config --add channels conda-forge

# Create conda environment (dependencies only — repo installed at runtime from checkout)
RUN cat <<'ENV_EOF' > /tmp/environment.yml
name: testbed
channels:
  - defaults
  - conda-forge
dependencies:
  - _libgcc_mutex=0.1=main
  - _openmp_mutex=5.1=1_gnu
  - ca-certificates=2024.9.24=h06a4308_0
  - exceptiongroup=1.2.0=py39h06a4308_0
  - iniconfig=1.1.1=pyhd3eb1b0_0
  - ld_impl_linux-64=2.40=h12ee557_0
  - libffi=3.4.4=h6a678d5_1
  - libgcc-ng=11.2.0=h1234567_1
  - libgomp=11.2.0=h1234567_1
  - libstdcxx-ng=11.2.0=h1234567_1
  - ncurses=6.4=h6a678d5_0
  - openssl=3.0.15=h5eee18b_0
  - packaging=24.1=py39h06a4308_0
  - pip=24.2=py39h06a4308_0
  - pluggy=1.0.0=py39h06a4308_1
  - pytest=7.4.4=py39h06a4308_0
  - python=3.9.20=he870216_1
  - readline=8.2=h5eee18b_0
  - setuptools=75.1.0=py39h06a4308_0
  - sqlite=3.45.3=h5eee18b_0
  - tk=8.6.14=h39e8969_0
  - tomli=2.0.1=py39h06a4308_0
  - tzdata=2024b=h04d1e81_0
  - wheel=0.44.0=py39h06a4308_0
  - xz=5.4.6=h5eee18b_1
  - zlib=1.2.13=h5eee18b_1
  - pip:
ENV_EOF
RUN conda env create --file /tmp/environment.yml && \
    conda clean -afy && \
    rm /tmp/environment.yml

# Environment variables

CMD ["bash"]

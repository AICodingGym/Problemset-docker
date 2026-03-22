FROM continuumio/miniconda3:latest

# System dependencies
RUN apt-get update && apt-get install -y \
    git build-essential libffi-dev libssl-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Working directory
RUN mkdir -p /app
WORKDIR /app

# Clone repo (only needed commit, not full history)
RUN git clone --depth 1 https://github.com/astropy/astropy.git . && \
    git fetch --depth 1 origin 362f6df12abf9bd769d4915fabf955c993ea22cf && \
    git checkout 362f6df12abf9bd769d4915fabf955c993ea22cf

# Create conda environment
RUN cat <<'ENV_EOF' > /tmp/environment.yml
name: testbed
channels:
  - defaults
  - conda-forge
dependencies:
  - _libgcc_mutex=0.1=main
  - _openmp_mutex=5.1=1_gnu
  - ca-certificates=2024.9.24=h06a4308_0
  - ld_impl_linux-64=2.40=h12ee557_0
  - libffi=3.4.4=h6a678d5_1
  - libgcc-ng=11.2.0=h1234567_1
  - libgomp=11.2.0=h1234567_1
  - libstdcxx-ng=11.2.0=h1234567_1
  - ncurses=6.4=h6a678d5_0
  - openssl=3.0.15=h5eee18b_0
  - pip=24.2=py39h06a4308_0
  - python=3.9.20=he870216_1
  - readline=8.2=h5eee18b_0
  - sqlite=3.45.3=h5eee18b_0
  - tk=8.6.14=h39e8969_0
  - tzdata=2024b=h04d1e81_0
  - wheel=0.44.0=py39h06a4308_0
  - xz=5.4.6=h5eee18b_1
  - zlib=1.2.13=h5eee18b_1
  - pip:
      - attrs==23.1.0
      - coverage==7.6.2
      - exceptiongroup==1.1.3
      - execnet==2.0.2
      - hypothesis==6.82.6
      - iniconfig==2.0.0
      - numpy==1.25.2
      - packaging==23.1
      - pluggy==1.3.0
      - psutil==5.9.5
      - pyerfa==2.0.0.3
      - pytest==7.4.0
      - pytest-arraydiff==0.5.0
      - pytest-astropy==0.10.0
      - pytest-astropy-header==0.2.2
      - pytest-cov==4.1.0
      - pytest-doctestplus==1.0.0
      - pytest-filter-subpackage==0.1.2
      - pytest-mock==3.11.1
      - pytest-openfiles==0.5.0
      - pytest-remotedata==0.4.0
      - pytest-xdist==3.3.1
      - pyyaml==6.0.1
      - setuptools==68.0.0
      - sortedcontainers==2.4.0
      - tomli==2.0.1
ENV_EOF
RUN conda env create --file /tmp/environment.yml && \
    conda clean -afy && \
    rm /tmp/environment.yml

# Install repo and dependencies
RUN /bin/bash -c "source activate testbed && \
    git fetch --tags "https://github.com/$REPO.git" || true
TARGET_TIMESTAMP=$(git show -s --format=%ci "$BASE_COMMIT")
git tag -l | while read tag; do TAG_COMMIT=$(git rev-list -n 1 "$tag"); TAG_TIME=$(git show -s --format=%ci "$TAG_COMMIT"); if [[ "$TAG_TIME" > "$TARGET_TIMESTAMP" ]]; then git tag -d "$tag"; fi; done
sed -i 's/requires = \["setuptools",/requires = \["setuptools==68.0.0",/' pyproject.toml
python -m pip install -e .[test] --verbose"

# Reset to base commit (code will be patched at runtime)
RUN git checkout b16c7d12ccbc7b2d20364b89fb44285bcbfede54 || true

# Environment variables

CMD ["bash"]

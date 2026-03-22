FROM continuumio/miniconda3:latest

# System dependencies
RUN apt-get update && apt-get install -y \
    git build-essential libffi-dev libssl-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Working directory
RUN mkdir -p /app
WORKDIR /app

# Clone repo (only needed commit, not full history)
RUN git clone --depth 1 https://github.com/pytest-dev/pytest.git . && \
    git fetch --depth 1 origin 693c3b7f61d4d32f8927a74f34ce8ac56d63958e && \
    git checkout 693c3b7f61d4d32f8927a74f34ce8ac56d63958e

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
      - atomicwrites==1.4.1
      - attrs==23.1.0
      - more-itertools==10.1.0
      - pluggy==0.11.0
      - py==1.11.0
      - setuptools==68.0.0
      - six==1.16.0
      - wcwidth==0.2.6
ENV_EOF
RUN conda env create --file /tmp/environment.yml && \
    conda clean -afy && \
    rm /tmp/environment.yml

# Install repo and dependencies
RUN /bin/bash -c "source activate testbed && \
    git fetch --tags "https://github.com/$REPO.git" || true
TARGET_TIMESTAMP=$(git show -s --format=%ci "$BASE_COMMIT")
git tag -l | while read tag; do TAG_COMMIT=$(git rev-list -n 1 "$tag"); TAG_TIME=$(git show -s --format=%ci "$TAG_COMMIT"); if [[ "$TAG_TIME" > "$TARGET_TIMESTAMP" ]]; then git tag -d "$tag"; fi; done
python -m pip install -e ."

# Reset to base commit (code will be patched at runtime)
RUN git checkout 58e6a09db49f34886ff13f3b7520dd0bcd7063cd || true

# Environment variables

CMD ["bash"]

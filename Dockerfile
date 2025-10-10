FROM apache/superset:5.0.0

ARG FOLDER=/app

WORKDIR ${FOLDER}

USER root

ENV SUPERSET_CONFIG_PATH='./superset_config.py'

# Install system dependencies required to build PostgreSQL client bindings
# (pkg-config, C build tools, and libpq headers) and then install the Python
# package. Assumes Debian/Ubuntu base image. If using Alpine, replace with the
# appropriate `apk add` packages (postgresql-dev, build-base, pkgconfig).
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    build-essential \
    libpq-dev \
    pkg-config \
    && apt-get upgrade -y \
    && rm -rf /var/lib/apt/lists/* \
    && pip install --upgrade pip \
    && pip install psycopg2-binary

COPY --chown=superset:superset . /app

RUN chmod +x ./superset-init.sh

USER superset

ENTRYPOINT [ "./superset-init.sh" ]
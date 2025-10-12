FROM apache/superset:5.0.0

ARG FOLDER=/app

WORKDIR ${FOLDER}

USER root

ENV SUPERSET_CONFIG_PATH='./superset_config.py'
ENV FLASK_ENV=production
ENV FLASK_DEBUG=0
ENV PYTHONUNBUFFERED=1

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
    && apt-get dist-upgrade -y \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/* \
    && pip install --upgrade pip \
    && pip install psycopg2-binary psycopg2 

# Install psycopg2 in the user's environment as well
RUN su - superset -c "pip install psycopg2-binary psycopg2"

COPY --chown=superset:superset . /app

RUN chmod +x ./superset-init.sh

USER superset

ENTRYPOINT [ "./superset-init.sh" ]
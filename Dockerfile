FROM apache/superset:5.0.0

ARG FOLDER=/app

WORKDIR ${FOLDER}

USER root

ENV SUPERSET_CONFIG_PATH='./superset_config.py'
ENV PYTHONPATH=/app
ENV FLASK_APP=app:create_app()
ENV PYTHONUNBUFFERED=1

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    build-essential \
    libpq-dev \
    pkg-config \
    && apt-get upgrade -y \
    && apt-get dist-upgrade -y \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/* \
    && uv pip install psycopg2-binary pillow

COPY --chown=superset:superset . /app

RUN chmod +x ./superset-init.sh

USER superset

ENTRYPOINT [ "./superset-init.sh" ]
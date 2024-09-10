# Stage 1: Build
FROM python:3.9 as builder

ENV PYTHONUNBUFFERED=1 \
    POETRY_NO_INTERACTION=1 \
    POETRY_VIRTUALENVS_IN_PROJECT=1 \
    POETRY_VIRTUALENVS_CREATE=1 \
    POETRY_CACHE_DIR=/tmp/poetry_cache

WORKDIR /app/
COPY pyproject.toml poetry.lock /app/
RUN apt-get update && \
    apt-get -y dist-upgrade && \
    apt install -y locales libcurl4-openssl-dev libssl-dev build-essential && \
    pip install -U pip poetry && \
    poetry install --without dev --no-root

# Stage 2: Runtime environment
FROM python:3.9

ENV PYTHONUNBUFFERED=1 \
    VIRTUAL_ENV=/app/.venv \
    PATH="/app/.venv/bin:$PATH"

COPY --from=builder ${VIRTUAL_ENV} ${VIRTUAL_ENV}
COPY . /app/

EXPOSE 9808

ENTRYPOINT ["python", "/app/cli.py"]

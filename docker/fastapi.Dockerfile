FROM python:3.14-alpine AS base

FROM base AS builder

COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

WORKDIR /usr/app

ENV UV_COMPILE_BYTECODE=1 \
  UV_LINK_MODE=copy \
  UV_NO_DEV=1 \
  UV_PYTHON_INSTALL_DIR=/usr/app/.python

COPY pyproject.toml uv.lock .python-version ./

RUN uv sync --locked --no-dev --no-install-project

COPY . .

RUN uv sync --locked --no-dev && \
  adduser -S -u 10001  python && \
  chown -R python /usr/app


ENV PATH="/usr/app/.venv/bin:$PATH" \
  PYTHONUNBUFFERED=1 \
  PYTHONDONTWRITEBYTECODE=1

USER python

EXPOSE 8000

ENTRYPOINT ["uv"]

CMD ["run", "fastapi", "run", "src/app.py"]

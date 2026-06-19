FROM python:3.12-slim AS base
FROM base
RUN apt-get update && apt-get install -y --no-install-recommends \
  curl \
  git \
  openssh-client \
  ca-certificates \
  && rm -rf /var/lib/apt/lists/* \
  && pip install --no-cache-dir ansible ansible-lint 
ENTRYPOINT [ "ansible" ]
CMD ["--version" ]
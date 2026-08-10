FROM frappe/erpnext:v16 AS base
FROM base AS builder
USER root
RUN apt-get update && apt-get install -y git && rm -rf /var/lib/apt/lists/*
USER frappe
RUN echo '{"socketio_port": 9000}' > /home/frappe/frappe-bench/sites/common_site_config.json

RUN yarn config set registry https://registry.npmjs.org \
  && yarn config set network-timeout 600000 \
  && yarn config set prefer-offline true \
  && yarn config set retry 5

RUN bench get-app  hrms --branch version-16
RUN bench get-app  insights --branch main
# RUN bench get-app  telephony
# RUN bench get-app  helpdesk --branch main

RUN bench build \
  --app hrms \
  --app insights \
  --force 
RUN echo '{}' > /home/frappe/frappe-bench/sites/common_site_config.json
FROM oven/bun:1.3.10-alpine AS base
FROM base AS builder
WORKDIR /usr/app
ENV NEXT_TELEMETRY_DISABLED=1
COPY package.json bun.lock ./
RUN bun install
COPY . .
RUN --mount=type=secret,id=ENV_ID,mode=0444 \
  --mount=type=secret,id=ENV_ID_2,mode=0444 \
  export ENV_ID=$(cat /run/secrets/ENV_ID)  && \
  export ENV_ID_2=$(cat /run/secrets/ENV_ID_2)  && \
  bun run build



FROM base AS prod
WORKDIR /usr/app

COPY --from=builder --chown=node:node /usr/app/public ./public
COPY --from=builder --chown=node:node /usr/app/.next/standalone ./
COPY --from=builder --chown=node:node /usr/app/.next/static ./.next/static


USER node

EXPOSE 3000

ENV NODE_ENV=production \
  HOSTNAME="0.0.0.0" \
  PORT=3000
ENTRYPOINT [ "bun" ]
CMD ["server.js"]
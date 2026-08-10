FROM oven/bun:1.3.9-alpine AS base
FROM base AS builder

WORKDIR /usr/app 
COPY package.json bun.lock ./ 
RUN bun install --frozen-lockfile 
COPY . . 
RUN bun run build

FROM base AS deploy
WORKDIR /usr/app
ENV NODE_ENV=production \
  PORT=3000 \
  HOST=0.0.0.0
COPY --from=builder /usr/app/.output ./.output
COPY --from=builder --chown=bun:bun /usr/app/package.json ./
# for prisma migration
# COPY --from=builder --chown=bun:bun /usr/app/prisma ./prisma
# COPY --from=builder --chown=bun:bun /usr/app/prisma.config.ts ./
EXPOSE 3000
ENTRYPOINT [ "bun" ]
CMD ["./.output/server/index.mjs"]
FROM ghcr.io/marx-org/base-node:22-alpine@sha256:2be4359005a5800a6aa0bbb3236327132b12509cc4c345f5bccfe6b4b56ebe43 AS builder
WORKDIR /app

COPY package*.json ./
RUN npm ci

COPY tsconfig.json ./
COPY src/ ./src/

RUN npm run build

FROM ghcr.io/marx-org/base-node:22-alpine@sha256:2be4359005a5800a6aa0bbb3236327132b12509cc4c345f5bccfe6b4b56ebe43 AS runtime
WORKDIR /app

COPY --from=builder /app/.mastra/output ./

EXPOSE 4111

CMD ["node", "index.mjs"]

FROM ghcr.io/marx-org/base-node:22-alpine@sha256:4c555748c9819babb757c7c328a12443b9d242edcfcc11cd196c24623dc704dd AS builder
WORKDIR /app

COPY package*.json ./
RUN npm ci

COPY tsconfig.json ./
COPY src/ ./src/

RUN npm run build

FROM ghcr.io/marx-org/base-node:22-alpine@sha256:4c555748c9819babb757c7c328a12443b9d242edcfcc11cd196c24623dc704dd AS runtime
WORKDIR /app

COPY --from=builder /app/.mastra/output ./

EXPOSE 4111

CMD ["node", "index.mjs"]

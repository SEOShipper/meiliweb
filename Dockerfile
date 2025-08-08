FROM node:24-alpine

RUN apk add --no-cache bash git openssh

WORKDIR /app

COPY package*.json pnpm-* ./

RUN yarn global add pnpm

COPY . .
RUN --mount=type=cache,target=/root/.local/share/pnpm/store pnpm install

WORKDIR /app/app 

RUN pnpm build

WORKDIR /app

EXPOSE 3000

CMD ["node", "./.output/server/index.mjs"]

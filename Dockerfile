FROM node:24-alpine

RUN apk add --no-cache bash git openssh

WORKDIR /app

COPY package*.json pnpm-* ./

RUN yarn global add pnpm

COPY . .
RUN pnpm install

WORKDIR /app/app # Correct working directory for the Nuxt build

RUN pnpm build

EXPOSE 3000

CMD ["node", "./output/server/index.mjs"]

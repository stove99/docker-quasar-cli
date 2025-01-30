## quasar cli

### Dockerfile

```dockerfile
FROM oven/bun:1.2-alpine

RUN bun add -g @quasar/cli

EXPOSE 4000

ENTRYPOINT ["/usr/local/bin/quasar"]

CMD ["-v"]
```

### cli 사용

```sh
docker run --rm stove/quasar-cli -v

docker run --rm stove/quasar-cli serve --help

docker run -d -v ./dist/spa:/app -p 4000:4000 stove/quasar-cli serve --history /app
```

### quasar spa app serve

```dockerfile
FROM node:22 AS builder

WORKDIR /usr/src/app

COPY package.json yarn.lock ./

RUN --mount=type=cache,target=/root/.yarn YARN_CACHE_FOLDER=/root/.yarn yarn install --frozen-lockfile

COPY . .

RUN yarn build


###
FROM stove/quasar-cli:2.4.1

COPY --from=builder /usr/src/app/dist/spa /app

EXPOSE 4000

ENTRYPOINT ["/usr/local/bin/quasar", "serve", "/app", "--history"]
```

```sh
docker build -t my-app .
docker run -p 4000:4000 -d my-app
```

### build

```sh
docker buildx create \
  --name container \
  --driver=docker-container

docker buildx build \
 --tag stove/quasar-cli:latest \
 --platform linux/arm64,linux/amd64 \
 --builder container \
 --push .
```

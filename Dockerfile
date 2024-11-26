# add release version of elixir phoenix app inside of docker container
FROM elixir:1.16.3-alpine AS builder

COPY . .

RUN mix deps.get
RUN mix release

FROM alpine:latest

RUN apk add --no-cache openssl

COPY --from=builder /app/_build/prod/rel/apps/releases/0.1.0/apps .

CMD ["./apps", "start"]

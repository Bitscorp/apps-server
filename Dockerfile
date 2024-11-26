FROM elixir:1.15 AS builder

ENV MIX_ENV=prod

# Install git
RUN apt-get update && \
    apt-get install -y git && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy mix files first to leverage Docker cache
COPY mix.exs mix.lock ./
COPY config config

# Install hex and rebar
RUN mix local.hex --force && \
    mix local.rebar --force

# Get dependencies
RUN mix deps.get

# Now copy the rest of the application code
COPY . /app

RUN rm -rf _build

RUN mix release

FROM alpine:latest

EXPOSE 4000

RUN apk add --no-cache openssl

COPY --from=builder /app/_build/prod/rel/apps/ /app

WORKDIR /app

CMD ["bin/apps", "start"]

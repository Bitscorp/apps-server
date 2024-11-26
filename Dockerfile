FROM elixir:latest AS builder

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

RUN mix release

FROM alpine:latest

RUN apk add --no-cache openssl

COPY --from=builder /app/_build/prod/rel/apps/releases/0.1.0/apps .

CMD ["./apps", "start"]

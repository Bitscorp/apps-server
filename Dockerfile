# BUILDER container

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


# RELEASE container

FROM debian:bookworm-20240926-slim

EXPOSE 4000

# Install basic utilities and dependencies
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    bash \
    ca-certificates \
    libssl-dev \
    imagemagick \
    pngcrush \
    optipng \
    fontconfig \
    locales \
    libfreetype6 \
    fonts-dejavu-core \
    wkhtmltopdf \
    libheif1 \
    pdftk \
    curl \
    && rm -rf /var/lib/apt/lists/*

RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen \
    && locale-gen en_US.UTF-8 \
    && update-locale LANG=en_US.UTF-8

# Set the environment variables for UTF-8
ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8

# Create /usr/local/bin directory if needed
RUN mkdir -p /usr/local/bin

# Run fc-cache to ensure fonts are available
RUN fc-cache -f

ENV REPLACE_OS_VARS=true
# For local dev, heroku will ignore this
EXPOSE $PORT

WORKDIR /app

COPY --from=builder /app/_build/prod/rel/apps/ /app

RUN true
COPY ./priv /app/priv

# set user permissions
# Create a group and user in Debian
RUN groupadd --system elixir
RUN useradd --no-create-home --system --gid elixir elixir

RUN chown -R elixir:elixir /app
USER elixir

WORKDIR /app

CMD ["bin/apps", "start"]

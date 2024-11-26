# Apps

To start your Phoenix server:

  * Run `mix setup` to install and setup dependencies
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix


## Development

* Run `docker compose up` to start the database and LiveAdmin
* Run `mix setup` to install and setup dependencies
* Run `just server` to start the Phoenix server
* Admin page accessible at [localhost:4000/admin](http://localhost:4000/admin)

## Deployment

* Run `docker build -t apps:latest .` to build the Docker image
* Run `docker run -p 4000:4000 apps:latest` to start the container

### Runtime Environment Variables

* `DATABASE_URL` - The database URL
* `SECRET_KEY_BASE` - The secret key base
* `PHX_HOST` - The host to use for the Phoenix server
* `PORT` - The port to use for the Phoenix server

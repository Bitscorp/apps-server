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


## Admin

* `ADMIN_USERNAME` - The username for the admin
* `ADMIN_PASSWORD` - The password for the admin

### Routes

* `/admin` - The admin page
* `/admin/subscriptions` - The subscriptions page
* `/admin/revenue_cat_events` - The revenue cat events page
* `/admin/users` - The users page
* `/admin/projects` - The projects page

## RevenueCat

* RevenueCat webhook: `/projects/:project_id/revenue_cat/webhook`:
  * `type`: The type of event (INITIAL_PURCHASE, CANCEL, EXPIRATION, etc.)
  * `product_id`: The product ID
  * `app_user_id`: The app user ID
  * `expiration_at_ms`: The expiration date in milliseconds

Creates a subscription if the user doesn't have one yet or updates the existing one by changing the expiration date and status (active, expired, cancelled, billing_issue).

migrate:
	mix ecto.migrate

test:
	mix test

psql:
	docker compose run psql

server:
	iex -S mix phx.server

outdated:
	mix hex.outdated

audit:
	mix deps.audit

reset:
	mix ecto.drop
	mix ecto.create
	mix ecto.migrate
	MIX_ENV=test mix ecto.drop
	MIX_ENV=test mix ecto.create
	MIX_ENV=test mix ecto.migrate

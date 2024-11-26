migrate:
	mix ecto.migrate

test:
	mix test

psql:
	docker compose run psql

server:
	iex -S mix phx.server

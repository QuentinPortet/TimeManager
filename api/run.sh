#!/bin/bash
# Docker entrypoint script.
# Wait until Postgres is ready
# Create, migrate, and seed database if it doesn't exist.
mix ecto.create
mix ecto.migrate
mix phx.server
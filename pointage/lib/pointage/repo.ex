defmodule Pointage.Repo do
  use Ecto.Repo,
    otp_app: :pointage,
    adapter: Ecto.Adapters.Postgres
end

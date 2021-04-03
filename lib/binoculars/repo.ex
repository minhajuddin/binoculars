defmodule Binoculars.Repo do
  use Ecto.Repo,
    otp_app: :binoculars,
    adapter: Ecto.Adapters.Postgres
end

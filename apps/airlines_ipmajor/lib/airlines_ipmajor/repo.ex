defmodule AirlinesIpmajor.Repo do
  use Ecto.Repo,
    otp_app: :airlines_ipmajor,
    adapter: Ecto.Adapters.MyXQL
end

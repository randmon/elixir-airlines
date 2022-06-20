defmodule AirlinesIpmajorWeb.Guardian do
  use Guardian, otp_app: :airlines_ipmajor_web

  alias AirlinesIpmajor.UserContext
  alias AirlinesIpmajor.UserContext.User

  def subject_for_token(user, _claims) do
    {:ok, to_string(user.id)}
  end

  def resource_from_claims(%{"sub" => id}) do
    case UserContext.get_user(id) do
      %User{} = u -> {:ok, u}
      nil -> {:error, :resource_not_found}
    end
  end
end

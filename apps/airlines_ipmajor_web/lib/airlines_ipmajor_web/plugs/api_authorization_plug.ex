defmodule AirlinesIpmajorWeb.Plugs.ApiAuthorizationPlug do
  import Plug.Conn
  alias AirlinesIpmajor.UserContext
  use AirlinesIpmajorWeb, :controller

  def init(options), do: options

  def call(conn, roles) do
    key = get_key(conn)
    verify_key(conn, key, roles)
  end

  defp get_key(conn) do
    get_req_header(conn, "x-api-key")
  end

  def verify_key(conn, key, roles) do
    if key == [] do
      conn |> send_resp(401, "Unauthorized - API key not provided") |> halt()
    else
      # search user by key
      user = UserContext.search_by_api_key(hd(key))
      if user == nil do
        conn |> send_resp(401, "Unauthorized - Invalid API key") |> halt()
      else
        conn |> grant_access(user, roles == [] || user.role in roles)
      end
    end
  end

  def grant_access(conn, user, true) do
    conn
      |> assign(:signed_in, true)
      |> assign(:signed_user, user)
  end

  def grant_access(conn, _user, false) do
    conn
      |> send_resp(401, "Unauthorized - Insufficient privileges") |> halt()
  end
end

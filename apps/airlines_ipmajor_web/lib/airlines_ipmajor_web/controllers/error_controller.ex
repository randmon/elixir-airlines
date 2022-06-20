defmodule AirlinesIpmajorWeb.ErrorController do
  use AirlinesIpmajorWeb, :controller

  def index(conn, _params) do
    redirect(conn, to: "/404")
  end

  def four_oh_four(conn, _params) do
    render(conn, "error.html", page_title: gettext("Page not found"), error_message: gettext("The page you requested was not found."), error_code: 404)
  end
end

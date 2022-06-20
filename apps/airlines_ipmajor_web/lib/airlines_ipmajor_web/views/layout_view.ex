defmodule AirlinesIpmajorWeb.LayoutView do
  use AirlinesIpmajorWeb, :view

  def new_locale(conn, locale, language_title) do
    "<a class=\"list-group-item px-2 py-1\" href=\"#{Routes.page_path(conn, :index, locale: locale)}\">#{language_title}</a>" |> raw
  end

  # Phoenix LiveDashboard is available only in development by default,
  # so we instruct Elixir to not warn if the dashboard route is missing.
  @compile {:no_warn_undefined, {Routes, :live_dashboard_path, 2}}

  def gravatar(email) do
    hash = email
    |> String.trim()
    |> String.downcase()
    |> :erlang.md5()
    |> Base.encode16(case: :lower)

    img = "http://www.gravatar.com/avatar/#{hash}?s=30&d=identicon"
    img_tag(img)
  end
end

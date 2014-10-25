defmodule Gardenhose.API do
  use Lazymaru.Router

  plug Plug.Static, at: "/static", from: "/my/static/path/"
  mount Router.Group

  def error(conn, _e) do
    "Server Error" |> text(500)
  end
end

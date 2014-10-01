defmodule Gardenhose.Router do
  use Phoenix.Router

  get "/", Gardenhose.PageController, :index, as: :pages

end

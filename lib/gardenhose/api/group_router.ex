defmodule Router.Group do
  use Lazymaru.Router

  alias Gardenhose.Repo, as: Repo
  alias Gardenhose.Model.Group, as: Group

  resource :groups do
    get do
      Repo.all(Group) |> json
    end

    route_param :id do
      get do
        Repo.get(Group, params[:id]) |> json
      end

      delete do

      end

    end
  end
end

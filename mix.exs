defmodule Gardenhose.Mixfile do
  use Mix.Project

  def project do
    [app: :gardenhose,
     version: "0.0.1",
     elixir: "~> 1.0.1",
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [applications: [:logger, :lazymaru, :postgrex, :ecto],
     mod: {Gardenhose, []}]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type `mix help deps` for more examples and options
  defp deps do
    [
      {:dialyze, "~> 0.1.3"},
      {:earmark, "~> 0.1", only: :dev},
      {:ex_doc, "~> 0.6", only: :dev},
      {:lazymaru, "~> 0.2.4"},
      {:postgrex, "~> 0.6.0"},
      {:ecto, "~> 0.2.5"},
      {:poison, "~> 1.2.0"}
    ]
  end
end

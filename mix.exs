defmodule Dbo.Mixfile do
  use Mix.Project

  def project do
    [app: :dbo,
     version: "0.2.0",
     elixir: "~> 1.0",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  def application do
    [applications: [:logger, :postgrex],
     mod: {Dbo, []}]
  end

  defp deps do
    [
      {:postgrex, "~> 0.8"},
      {:poison, "~> 1.4.0"}
    ]
  end
end

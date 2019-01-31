defmodule Mixfile do
  use Mix.Project

  def project do
    [
      app: :dotfiles,
      version: "0.0.1",
      # elixir: "~> 1.7",
      deps: deps(),
      elixirc_paths: ['.']
    ]
  end

  defp deps do
    []
  end
end

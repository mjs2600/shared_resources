defmodule SharedResources.Mixfile do
  use Mix.Project

  def project do
    [ app: :shared_resources,
      version: "0.0.1",
      dynamos: [SharedResources.Dynamo],
      compilers: [:elixir, :dynamo, :app],
      env: [prod: [compile_path: "ebin"]],
      compile_path: "tmp/#{Mix.env}/shared_resources/ebin",
      deps: deps ]
  end

  # Configuration for the OTP application
  def application do
    [ applications: [:cowboy, :dynamo, :bcrypt],
      mod: { SharedResources, [] } ]
  end

  defp deps do
    [ { :cowboy, github: "extend/cowboy" },
      { :dynamo, github: "elixir-lang/dynamo" },
      { :amnesia, github: "meh/amnesia" },
      { :jsonex, github: "marcelog/jsonex" },
      { :bcrypt, github: "smarkets/erlang-bcrypt" }]
  end
end

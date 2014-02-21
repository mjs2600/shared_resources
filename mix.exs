defmodule SharedResources.Mixfile do
  use Mix.Project

  def project do
    [ app: :shared_resources,
      version: "0.1.0",
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
      { :dynamo, github: "dynamo/dynamo" },
      { :postgrex, github: "ericmj/postgrex" },
      { :ecto, github: "elixir-lang/ecto" },
      { :jsonex, github: "marcelog/jsonex" },
      { :bcrypt, github: "opscode/erlang-bcrypt" }]
  end
end

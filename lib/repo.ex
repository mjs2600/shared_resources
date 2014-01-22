defmodule Repo do
  use Ecto.Repo, adapter: Ecto.Adapters.Postgres

  def url do
    "ecto://root@localhost/shared_resources"
  end

  def priv do
    app_dir(:shared_resources, "priv/repo")
  end
end

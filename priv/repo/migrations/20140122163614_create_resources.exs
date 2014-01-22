defmodule Repo.Migrations.CreateResources do
  use Ecto.Migration

  def up do
    "CREATE TABLE IF NOT EXISTS resources(id serial primary key, name character varying(255), location character varying(255), user_id integer)"
  end

  def down do
    "DROP TABLE resources"
  end
end

defmodule Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def up do
    "CREATE TABLE IF NOT EXISTS users(id serial primary key, name character varying(255), email character varying(255), encrypted_password character varying(255), salt character varying(255))"
  end

  def down do
    "DROP TABLE users"
  end
end

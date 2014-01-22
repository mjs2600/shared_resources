defmodule Repo.Migrations.AddAdminToUsers do
  use Ecto.Migration

  def up do
    "ALTER TABLE users ADD COLUMN admin boolean DEFAULT false"
  end

  def down do
    "ALTER TABLE users REMOVE COLUMN admin"
  end
end

defmodule SharedResources.User do
  use Amnesia
  require Exquisite

  def find_user_by_name(id) do
    query = Exquisite.match SharedResources.Database.User,
            where: id == id
  end

  def find_user_by_name(name) do
    query = Exquisite.match SharedResources.Database.User,
            where: name == name
  end

  defp find_with_query(query) do
    Amnesia.transaction do
      result = SharedResources.Database.User.select query
      {_, [user | _], _} = result

      user
    end
  end
end

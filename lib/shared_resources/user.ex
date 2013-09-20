defmodule SharedResources.User do
  use Amnesia
  require Exquisite

  def find_by_id(id) do
    query = Exquisite.match SharedResources.Database.User,
            where: id == id
    find_with_query(query)
  end

  def find_by_name(name) do
    query = Exquisite.match SharedResources.Database.User,
            where: name == name
    find_with_query(query)
  end

  defp find_with_query(query) do
    Amnesia.transaction do
      result = SharedResources.Database.User.select query
      {_, [user | _], _} = result

      user
    end
  end
end

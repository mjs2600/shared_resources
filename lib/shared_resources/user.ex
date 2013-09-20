defmodule SharedResources.User do
  use Amnesia
  require Exquisite

  def create(params) do
    name = params[:name]
    email_address = params[:email_address]
    Amnesia.transaction do
      user = SharedResources.Database.User[name: name,
                                                   email_address: email_address,
                                                   id: SharedResources.Database.generate_id]
      user.write
    end
  end

  def index do
    query = Exquisite.match SharedResources.Database.User

    response = Amnesia.transaction do
      SharedResources.Database.User.select query
    end

    SharedResources.Database.extract_response response
  end

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

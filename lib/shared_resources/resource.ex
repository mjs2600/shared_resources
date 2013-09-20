defmodule SharedResources.Resource do
  use Amnesia
  require Exquisite

  def index do
    query = Exquisite.match SharedResources.Database.Resource

    response = Amnesia.transaction do
      SharedResources.Database.Resource.select query
    end

    extract_response response
  end

  def create(params) do
    name = params[:name]
    location = params[:location]

    Amnesia.transaction do
      resource = SharedResources.Database.Resource[name: name,
                                                   location: location,
                                                   id: make_id]
      resource.write
    end
  end

  def find_by_id(id) do
    query = Exquisite.match SharedResources.Database.Resource,
            where: id == id

    Amnesia.transaction do
      result = SharedResources.Database.Resource.select query
      {_, [resource | _], _} = result

      resource
    end
  end

  def check_in(id) do
    resource = find_by_id(id)
    resource.check_in()
  end

  def check_out(id) do
    resource = find_by_id(id)
    resource.check_out(4)
  end

  def make_id do
    time
  end

  def time do
    :erlang.now |> tuple_to_list |> Enum.join
  end

  defp extract_response({_, records, _}) do
    records
  end

  defp extract_response(_) do
    []
  end
end

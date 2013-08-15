defmodule SharedResources.Assets do
  use Amnesia
  require Exquisite

  def resource_index do
    query = Exquisite.match SharedResources.Database.Resource

    response = Amnesia.transaction do
      SharedResources.Database.Resource.select query
    end

    extract_response response
  end

  def resource_create(params)  do
    name = params[:name]
    location = params[:location]

    Amnesia.transaction do
      resource = SharedResources.Database.Resource[name: name, location: location]
      resource.write
    end
  end

  defp extract_response({_, records, _}) do
    records
  end

  defp extract_response(_) do
    []
  end

end

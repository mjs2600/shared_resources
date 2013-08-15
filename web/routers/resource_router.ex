defmodule ResourceRouter do
  use Dynamo.Router
  import SharedResources.Assets


  get "/" do
    conn = conn.assign(:resources, resource_index)
    render conn, "index.html"
  end

  post "/" do
    resource_create(conn.params)
    redirect conn, to: "/"
  end

  get "/new" do
    render conn, "new_resource.html"
  end
end

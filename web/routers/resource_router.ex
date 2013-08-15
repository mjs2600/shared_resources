defmodule ResourceRouter do
  use Dynamo.Router
  import SharedResources.Resource

  get "/" do
    conn = conn.assign(:resources, index)
    render conn, "index.html"
  end

  post "/" do
    create(conn.params)
    redirect conn, to: "/"
  end

  get "/new" do
    render conn, "new_resource.html"
  end
end

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

  post "/:id/check-in" do
    conn = conn.assign(:resources, index)
    conn.resp 200, Jsonex.encode [check_in: id]
  end

  post "/:id/check-out" do
    conn = conn.assign(:resources, index)
    conn.resp 200, Jsonex.encode [check_out: id]
  end
end

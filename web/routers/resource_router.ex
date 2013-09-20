defmodule ResourceRouter do
  use Dynamo.Router

  import SharedResources.Resource
  require Exquisite

  get "/" do
    conn = conn.assign(:resources, index)
    render conn, "resources/index"
  end

  post "/" do
    create(conn.params)
    redirect conn, to: "resources/"
  end

  get "/new" do
    render conn, "resources/new"
  end

  post "/:id/check-in" do
    check_in(id)

    conn = conn.assign(:resources, index)
    conn.resp 200, Jsonex.encode [check_in: id]
  end

  post "/:id/check-out" do
    check_out(id)

    conn = conn.assign(:resources, index)
    conn.resp 200, Jsonex.encode [check_out: id]
  end
end

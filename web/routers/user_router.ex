defmodule UserRouter do
  use Dynamo.Router

  import SharedResources.User
  require Exquisite

  get "/" do
    conn = conn.assign(:users, index)
    render conn, "users/index"
  end

  post "/" do
    create(conn.params)
    redirect conn, to: "/users"
  end

  get "/new" do
    render conn, "users/new.html"
  end
end

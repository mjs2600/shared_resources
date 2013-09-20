defmodule UserRouter do
  use Dynamo.Router

  # import SharedResources.User
  require Exquisite

  get "/" do
    foo = [{0, "Apple"}, {1, "Orange"}, {2, "Banana"}]
    conn = conn.assign(:users, foo)
    render conn, "usersindex"
  end

  post "/" do
    # create(conn.params)
    redirect conn, to: "/"
  end

  get "/new" do
    render conn, "users/new.html"
  end
end

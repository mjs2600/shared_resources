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
  
  get "/login" do
    render conn, "users/login"
  end
  
  post "/login" do
    user = authenticate(conn.params[:email_address], conn.params[:password])
    if user do
      conn = put_session(conn, :user_id, user.id)
      conn = conn.assign(:notices, "You logged in!!!")
      redirect conn, to: "/resources"
    else
      conn = conn.assign(:errors, "You done messed up")
      render conn, "users/login"
    end
  end
  
  get "/logout" do
    conn = delete_session(conn, :user_id)
    conn = conn.assign(:notices, "Thanks for visiting \"Shared Resources\"&copy;!")
    redirect conn, to: "/resources"
  end
end

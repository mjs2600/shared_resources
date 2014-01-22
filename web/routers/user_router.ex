defmodule UserRouter do
  use Dynamo.Router

  import SharedResources.User
  import ApplicationRouter, only: [authenticate_user: 1]
  require Exquisite

  get "/" do
    conn = conn.assign(:users, index)
    render conn, "users/index"
  end

  @prepare :authenticate_user
  post "/" do
    create(conn.params)
    redirect conn, to: "/users"
  end

  @prepare :authenticate_user
  get "/new" do
    render conn, "users/new.html"
  end
  
  @prepare :authenticate_user
  # TODO: Only allow people to edit themselves, unless they're an admin
  get "/:id/edit" do
    conn = conn.assign(:user, find_by_id(id))
    render conn, "users/edit"
  end
  
  get "/login" do
    render conn, "users/login"
  end
  
  post "/login" do
    user = authenticate(conn.params[:email_address], conn.params[:password])
    if user do
      conn = put_session(conn, :user_id, user.id)
      conn = put_session(conn, :notices, "You logged in!!!")
      redirect conn, to: "/resources"
    else
      conn = conn.assign(:errors, "You done messed up")
      render conn, "users/login"
    end
  end
  
  get "/logout" do
    conn = delete_session(conn, :user_id)
    conn = put_session(conn, :notices, "Thanks for visiting \"Shared Resources\"&copy;, your center for resources that need sharing!")
    redirect conn, to: "/resources"
  end
  
  @prepare :authenticate_user
  # TODO: Only allow people to edit themselves, unless they're an admin
  post "/:id" do
    update(conn.params)
    redirect conn, to: "/users"
  end
end

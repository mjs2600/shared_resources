defmodule UserRouter do
  use Dynamo.Router

  import SharedResources.User
  import ApplicationRouter, only: [authenticate_user: 1, current_user: 1, authorize_admin: 1]

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
  @finalize :authorize_current_user_or_admin
  get "/:id/edit" do
    user = find_by_id(id)
    conn = conn.assign(:user, user)
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
  @finalize :authorize_current_user_or_admin
  get "/:id/delete" do
    user = find_by_id(id)
    user_is_current_user = user == current_user(conn)
    if current_user_or_admin(conn) do
      user.destroy
      conn = put_session(conn, :notices, "Zed's dead, baby. Zed's dead.")
    end
    if user_is_current_user, do: conn = delete_session(conn, :user_id)
    redirect conn, to: "/resources"
  end

  @prepare :authenticate_user
  @finalize :authorize_current_user_or_admin
  post "/:id" do
    if current_user_or_admin(conn), do: update(conn.params)
    redirect conn, to: "/users"
  end

  defp authorize_current_user_or_admin(conn) do
    unless current_user_or_admin(conn) do
      conn = put_session(conn, :errors, "You can't do that the them! What are you thinking?")
      redirect conn, to: "/resources"
    end
  end

  defp current_user_or_admin(conn) do
    user = find_by_id(conn.params[:id])
    current_user = current_user(conn)
    current_user == user || current_user.admin 
  end
end

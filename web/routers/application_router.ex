defmodule ApplicationRouter do
  use Dynamo.Router

  prepare do
    # Pick which parts of the request you want to fetch
    # You can comment the line below if you don't need
    # any of them or move them to a forwarded router
    conn = conn.fetch([:cookies, :params, :session])
    conn = conn.assign(:current_user, current_user(conn))

    conn = conn.assign(:notices, get_session(conn, :notices))
    conn = conn.assign(:errors, get_session(conn, :errors))
    conn = delete_session(conn, :notices)
    conn = delete_session(conn, :errors)

    conn.assign :layout, "application_layout"
  end

  def current_user(conn) do
    user_id = get_session(conn, :user_id)
    if user_id do
      SharedResources.User.find_by_id(user_id)
    end
  end

  def authenticate_user(conn) do
    unless current_user(conn) do
      conn = put_session(conn, :errors, "You must be logged in to do that!")
      redirect conn, to: "/resources"
    end
  end
  
  def authorize_admin(conn) do
    unless current_user(conn) && current_user(conn).admin do
      conn = put_session(conn, :errors, "Hey, only admins can do that!  You've been reported to the authorities.")
      redirect conn, to: "/resources"
    end
  end

  # It is common to break your Dynamo in many
  # routers forwarding the requests between them
  forward "/users", to: UserRouter
  forward "/resources", to: ResourceRouter

  get "/" do
    redirect conn, to: "/resources"
  end
end

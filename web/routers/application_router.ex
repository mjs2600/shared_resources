defmodule ApplicationRouter do
  use Dynamo.Router

  prepare do
    # Pick which parts of the request you want to fetch
    # You can comment the line below if you don't need
    # any of them or move them to a forwarded router
    conn = conn.fetch([:cookies, :params, :session])
    conn = conn.assign(:current_user, current_user(conn))
    conn.assign :layout, "application_layout"
  end
  
  defp current_user(conn) do
    user_id = get_session(conn, :user_id)
    if user_id do
      SharedResources.User.find_by_id(user_id)
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

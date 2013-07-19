defmodule ApplicationRouter do
  use Dynamo.Router

  prepare do
    # Pick which parts of the request you want to fetch
    # You can comment the line below if you don't need
    # any of them or move them to a forwarded router
    conn.fetch([:cookies, :params])
    conn.assign :layout, "application_layout"
  end

  # It is common to break your Dynamo in many
  # routers forwarding the requests between them
  # forward "/posts", to: PostsRouter

  get "/" do
    conn = conn.assign(:resources, [
      [name: "Van", location: "327 Main St", checked_out: nil],
      [name: "Conference Room", location: "329 Main St", checked_out: "Joe Jackson"]
    ])
    render conn, "index.html"
  end
end

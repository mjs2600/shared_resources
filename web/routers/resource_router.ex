defmodule ResourceRouter do
  use Dynamo.Router

  import SharedResources.Resource
  import SharedResources.CheckOutHelper
  require Exquisite

  get "/" do
    conn = conn.assign(:resources, index)
    conn = conn.assign(:users, SharedResources.User.index)
    render conn, "resources/index"
  end

  post "/" do
    create(conn.params)
    redirect conn, to: "/"
  end
  
  put "/:id" do
    update(conn.params)
    
  end

  get "/new" do
    render conn, "resources/new"
  end

  post "/:id/check-in" do
    check_in(id)
    conn.resp 200, Jsonex.encode [
      check_in: id,
      action_text: action_text(true),
      action_element_class: action_element_class(true),
    ]
  end

  post "/:id/check-out" do
    user_id = conn.params[:user_id]
    check_out(id, user_id)
    conn.resp 200, Jsonex.encode [
      check_out: id,
      action_text: action_text(true),
      action_element_class: action_element_class(true),
    ]
  end
end

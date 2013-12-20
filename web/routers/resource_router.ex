defmodule ResourceRouter do
  use Dynamo.Router

  import SharedResources.Resource
  import SharedResources.CheckOutHelper
  import ApplicationRouter, only: [authenticate_user: 1, current_user: 1]
  require Exquisite

  get "/" do
    conn = conn.assign(:resources, index)
    conn = conn.assign(:users, SharedResources.User.index)
    render conn, "resources/index"
  end

  @prepare :authenticate_user
  post "/" do
    create(conn.params)
    redirect conn, to: "/"
  end
  
  @prepare :authenticate_user
  get "/:id/edit" do
    conn = conn.assign(:resource, find_by_id(id))
    render conn, "resources/edit"
  end
  
  @prepare :authenticate_user
  post "/:id" do
    update(conn.params)
    redirect conn, to: "/resources"
  end

  @prepare :authenticate_user
  get "/new" do
    render conn, "resources/new"
  end

  @prepare :authenticate_user
  post "/:id/check-in" do
    check_in(id)
    resource = find_by_id(id)
    conn.resp 200, Jsonex.encode [
      check_in: id,
      action_text: action_text(false),
      action_element_class: action_element_class(true),
      checked_out: false,
      status_message: status_message(false, resource),
      action_classes: action_classes
    ]
  end

  @prepare :authenticate_user
  post "/:id/check-out" do
    check_out(id, current_user(conn).id)
    resource = find_by_id(id)
    conn.resp 200, Jsonex.encode [
      check_out: id,
      action_text: action_text(true),
      action_element_class: action_element_class(true),
      checked_out: true,
      status_message: status_message(true, resource),
      action_classes: action_classes
    ]
  end
end

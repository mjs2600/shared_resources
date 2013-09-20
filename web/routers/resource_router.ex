defmodule ResourceRouter do
  use Dynamo.Router
  use Amnesia
  
  import SharedResources.Resource
  require Exquisite
  

  get "/" do
    conn = conn.assign(:resources, index)
    render conn, "index.html"
  end

  post "/" do
    create(conn.params)
    redirect conn, to: "/"
  end

  get "/new" do
    render conn, "new_resource.html"
  end

  post "/:id/check-in" do
    #query = Exquisite.match SharedResources.Database.Resource,
            #where: id == id

    #response = Amnesia.transaction do
      #result = SharedResources.Database.Resource.select query
      #{_, [resource | _], _} = result
      #resource.checked_out_by(nil)
      #resource.write
    #end

    check_in(id)
 
    conn = conn.assign(:resources, index)
    conn.resp 200, Jsonex.encode [check_in: id]
  end

  post "/:id/check-out" do
    check_out(id)
 
    conn = conn.assign(:resources, index)
    conn.resp 200, Jsonex.encode [check_out: id]
  end
end

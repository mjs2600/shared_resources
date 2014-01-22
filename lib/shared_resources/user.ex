defmodule SharedResources.User do
  use Ecto.Model

  queryable "users" do
    has_many :resources, Resources
    field :name
    field :email_address
    field :salt
    field :encrypted_password
  end

  def create(params) do
    name = params[:name]
    email_address = params[:email_address]
    {encrypted_password, salt} = SharedResources.User.Password.create(params[:password])

    user = SharedResources.User.new(name: name, email_address: email_address, salt: salt, encrypted_password: encrypted_password)
    Repo.create(user)
  end

  def update(params) do
    user = find_by_id(params[:id])
    name          = params[:name] || user.name
    email_address = params[:email_address] || user.email_address
    
    Amnesia.transaction do
      user.name(name).email_address(email_address).write
      update_password(user, params[:password])
    end
  end

  def index do
    query = Exquisite.match SharedResources.Database.User

    response = Amnesia.transaction do
      SharedResources.Database.User.select query
    end

    SharedResources.Database.extract_response response
  end

  def find_by_id(id) do
    SharedResources.Database.User.read!(id)
  end

  def find_by_name(search_name) do
    query = SharedResources.Database.User.where(user.name == search_name, qualified: true)
    find_with_query(query)
  end
  
  def authenticate(email_address_query, password) do
    query = Exquisite.match SharedResources.Database.User,
            where: email_address == email_address_query
    user = find_with_query(query)
    authenticate_user(user, password)
  end

  defp authenticate_user(nil, _password) do
    false
  end

  defp authenticate_user(user, password) do
    if SharedResources.User.Password.encrypt(password, user.salt) == user.encrypted_password do
      user
    end
  end
  
  defp update_password(_user, "") do
  end
  
  defp update_password(user, password) do
    encrypted_password = SharedResources.User.Password.encrypt(password, user.salt)
    user.encrypted_password(encrypted_password).write
  end

  defp find_with_query(query) do
    Amnesia.transaction do
      result = SharedResources.Database.User.select query
      parse_query_result(result)
    end
  end
  
  defp parse_query_result({_, [user | _], _}) do
    user
  end
  
  defp parse_query_result(_) do
    nil
  end
end

defmodule SharedResources.User do
  use Ecto.Model
  import Ecto.Query

  queryable "users" do
    has_many :resources, Resource
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
    user = Repo.get(SharedResources.User, params[:id])
    if params[:name] do
      user = user.name(params[:name]) 
    end

    if params[:email_address] do
      user = user.email_address(params[:email_address])
    end

    user = update_password(user, params[:password])

    Repo.update(user)
  end

  def index do
    Repo.all(SharedResources.User)
  end

  def find_by_id(id) do
    Repo.get(SharedResources.User, id)
  end

  def find_by_name(name) do
    query = from u in SharedResources.User,
      where: u.name == ^(name),
      select: u

    Repo.get(query)
  end

  # TODO: Call on User instead
  def authenticate(email_address, password) do
    query = from u in SharedResources.User,
            where: u.email_address == ^(email_address),
            select: u

    user = Repo.get(query)
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

  defp update_password(user, "") do
    user
  end

  defp update_password(user, password) do
    encrypted_password = SharedResources.User.Password.encrypt(password, user.salt)

    user.encrypted_password(encrypted_password)
  end

  def check_password(user, password) do
    user.encrypted_password == SharedResources.User.Password.encrypt(password)
  end

  def set_password(user, password) do
    user.encrypted_password(SharedResources.User.Password.encrypt(password))
    Repo.update(user)
  end

end

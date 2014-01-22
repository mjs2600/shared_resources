defmodule SharedResources.Resource do
  use Ecto.Model
  import Ecto.Query

  queryable "resources" do
    belongs_to :user, User # TODO: Try this without specifying the class name
    field :name
    field :location
  end

  def index do
    Repo.all(SharedResources.Resource)
  end
  
  def find_by_id(id) do
    Repo.get(SharedResources.Resource, id)
  end

  def create(params) do
    resource = SharedResources.Resource.new(
      name: params[:name],
      location: params[:location]
    )
    Repo.create(resource)
  end

  def update(params) do
    resource = Repo.get(SharedResources.Resource, params[:id])
    resource = resource.name(params[:name]) when params[:name]
    resource = resource.location(params[:location]) when params[:location]
    
    Repo.update(resource)
  end

  def check_in(id, current_user_id) do
    resource = Repo.get(SharedResources.Resource, params[:id])
    if resource.checked_out_by?(current_user_id) do
      resource.check_in()
    end
  end

  def check_out(id, user_id) do
    resource = Repo.get(SharedResources.Resource, params[:id])
    resource.check_out(user_id)
  end

  def checked_out?(resource) do
    !resource.checked_in?
  end
  
  def checked_in?(resource) do
    !resource.checked_out_by!
  end
  
  def checkable?(nil, _resource) do
    false
  end
  
  def checkable?(user, resource) do
    resource.checked_in? || resource.checked_out_by?(user.id)
  end
  
  def checked_out_by?(user_id, resource) do
    resource.user_id == user_id
  end

  def checked_out_by(resource) do
    Repo.get(SharedResources.User, resource.user_id)
  end

  def checked_out_by!(resource) do
    resource.checked_out_by
  end

  def check_in(resource) do
    resource = resource.user_id(nil)
    Repo.update(resource)
  end

  def check_out(user_id, resource) do
    resource = resource.user_id(user_id)
    Repo.update(resource)
  end
  
end

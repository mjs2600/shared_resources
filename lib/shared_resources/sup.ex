defmodule SharedResources.Sup do
  use Supervisor.Behaviour

  def start_link do
    :supervisor.start_link(SharedResources.Sup, [])
  end

  def init([]) do
    tree = [ worker(Repo, []), worker(Coffee, []) ]
    supervise(tree, strategy: :one_for_one)
  end
end

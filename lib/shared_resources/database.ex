use Amnesia
require Exquisite

defdatabase SharedResources.Database do

  def start do
    Amnesia.Schema.create
    Amnesia.start
    create( disk: [node])
    wait
  end

  deftable Resource, [:name, :location], type: :bag

end

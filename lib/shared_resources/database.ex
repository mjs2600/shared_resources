use Amnesia
require Exquisite

defdatabase SharedResources.Database do

  def start do
    Amnesia.Schema.create
    Amnesia.start
    create( disk: [node])
    wait
  end

  deftable Resource,
           [:id,
            :name,
            :location,
            :checked_out_by],
           type: :bag
end

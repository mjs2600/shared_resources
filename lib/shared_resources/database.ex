use Amnesia
require Exquisite

defdatabase SharedResources.Database do

  def start do
    Amnesia.Schema.create
    Amnesia.start
    create( disk: [node])
    wait
  end

  deftable User

  deftable Resource, [:id, :name, :location, :user_id], type: :ordered_set do
    def checked_out_by(self) do
      User.read(self.user_id)
    end

    def checked_out_by!(self) do
      User.read!(self.user_id)
    end

    def check_in(self) do
      Amnesia.transaction do
        self.user_id(nil).write
      end
    end

    def check_out(user_id, self) do
      Amnesia.transaction do
        self.user_id(user_id).write
      end
    end
  end

  deftable User, [:id, :user_name, :email_address], type: :ordered_set do
  end
end

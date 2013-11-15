use Amnesia
require Exquisite

defdatabase SharedResources.Database do

  def start do
    Amnesia.Schema.create
    Amnesia.start
    create(disk: [node])
    wait
  end

  def generate_id do
    time
  end

  defp time do
    :erlang.now |> tuple_to_list |> Enum.join
  end

  def extract_response({_, records, _}) do
    records
  end

  def extract_response(_) do
    []
  end

  deftable User, [:id, :name, :email_address, :encrypted_password, :salt], type: :ordered_set do
    def check_password(self, password) do
      self.encrypted_password == SharedResources.User.Password.encrypt(password)
    end
    
    def set_password(self, password) do
      self.encrypted_password(SharedResources.User.Password.encrypt(password)).write!
    end
  end

  deftable Resource, [:id, :name, :location, :user_id], type: :ordered_set do
    def checked_out?(self) do
      !!self.checked_out_by!
    end

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
end

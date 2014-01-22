defmodule SharedResources.User.Password do
  def encrypt(password, salt) do
    {:ok, hash} = :bcrypt.hashpw(password, salt)
    hash
  end

  def gen_salt do
    {:ok, salt} = :bcrypt.gen_salt

    salt
  end

  def create(password) do
    salt = gen_salt |> String.from_char_list!
    encrypted_password = encrypt(password, salt) |> String.from_char_list!
    {encrypted_password, salt}
  end
end

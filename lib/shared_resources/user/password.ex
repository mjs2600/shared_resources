defmodule SharedResources.User.Password do
  def encrypt(password, salt) do
    {:ok, hash} = :bcrypt.hashpw(password, salt)
    string_hash = hash |> String.from_char_list!

    string_hash
  end

  def gen_salt do
    {:ok, salt} = :bcrypt.gen_salt
    string_salt = salt |> String.from_char_list!

    string_salt
  end

  def create(password) do
    salt = gen_salt
    encrypted_password = encrypt(password, salt)
    {encrypted_password, salt}
  end
end

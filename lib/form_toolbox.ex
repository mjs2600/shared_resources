defmodule FormToolbox do
  
  def string_to_boolean("true") do
    true
  end
  
  def string_to_boolean(_str) do
    false
  end
end
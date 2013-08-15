defmodule SharedResources.CheckOutHelper do
  def button_class(nil) do
    'check-in'
  end

  def button_class(_) do
    'check-out'
  end
end
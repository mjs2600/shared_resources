defmodule SharedResources.CheckOutHelper do
  def button_class(nil) do
    'check-out'
  end

  def button_class(_) do
    'check-in'
  end
end
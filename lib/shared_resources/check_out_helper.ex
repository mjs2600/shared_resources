defmodule SharedResources.CheckOutHelper do
  def action_element_class(true) do
    'check-out'
  end

  def action_element_class(false) do
    'check-in'
  end

  def status_message(true, resource) do
    "Checked out by #{resource.checked_out_by!.name}"
  end

  def status_message(false, resource) do
    "Find it in the #{resource.location}"
  end

  def action_text(true) do
    'Check In'
  end

  def action_text(false) do
    'Check Out'
  end
end

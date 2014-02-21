defmodule SharedResources.CheckOutHelper do
  def action_element_class(true) do
    "check-in"
  end

  def action_element_class(false) do
    "check-out"
  end

  def status_message(true, resource) do
    "Checked out by #{resource.checked_out_by!.name}"
  end

  def status_message(false, resource) do
    "Find it where? #{resource.location}"
  end

  def action_text(true) do
    "Check In"
  end

  def action_text(false) do
    "Check Out"
  end

  def status_class(true) do
    "checked-out"
  end

  def status_class(false) do
    "checked-in"
  end

  def action_classes do
    [action_element_class(true), action_element_class(false)]
    true
  end
end

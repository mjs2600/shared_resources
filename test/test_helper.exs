Dynamo.under_test(SharedResources.Dynamo)
Dynamo.Loader.enable
ExUnit.start

defmodule SharedResources.TestCase do
  use ExUnit.CaseTemplate

  # Enable code reloading on test cases
  setup do
    Dynamo.Loader.enable
    :ok
  end
end

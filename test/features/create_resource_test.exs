Code.require_file "../../test_helper.exs", __FILE__

# Feature tests goes through the Dynamo.under_test
# and are meant to test the full stack.
defmodule CreateResrouceTest do
  use SharedResources.TestCase
  use Dynamo.HTTP.Case

  test "returns OK" do
    conn = get("/resources/new")
    assert conn.resp_body == 200
  end

  test "renders an edit page" do
    conn = get("/resources/new")
    assert conn.resp_body == %r/new resource/
  end
end

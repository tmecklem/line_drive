defmodule LineDrive.ActivityTypes.ListActivityTypesTest do
  @moduledoc false
  use LineDrive.PipedriveClientCase, async: false

  alias LineDrive.{
    ActivityType,
    ActivityTypes
  }

  describe "list_activity_types" do
    test "it forms a correct request and returns a list of activity types", %{client: client} do
      assert {:ok, [%ActivityType{name: "Call"} | _]} = ActivityTypes.list_activity_types(client)
    end
  end
end

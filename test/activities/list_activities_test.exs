defmodule LineDrive.ActivityTypes.ListActivitiesTest do
  @moduledoc false
  use LineDrive.PipedriveClientCase, async: false

  alias LineDrive.{
    Activities,
    Activity
  }

  describe "list_activities" do
    test "it forms a correct request and returns a list of activities", %{client: client} do
      assert {:ok, [%Activity{subject: "Meeting"} | _]} = Activities.list_activities(client)
    end
  end
end

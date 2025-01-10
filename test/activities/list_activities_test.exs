defmodule LineDrive.Activities.ListActivitiesTest do
  @moduledoc false
  use LineDrive.PipedriveClientCase, async: false

  alias LineDrive.Activities
  alias LineDrive.Activity
  alias LineDrive.PagedResult

  describe "list_activities" do
    test "it forms a correct request and returns a paged result", %{client: client} do
      assert {:ok,
              %PagedResult{
                success: true,
                data: [%Activity{} | _],
                additional_data: additional_data
              }} =
               Activities.list_activities(client)

      assert additional_data.next_cursor == "MTIzNDU2Nzg5MA=="
      assert additional_data.limit == 100
    end

    test "it accepts cursor and limit parameters", %{client: client} do
      assert {:ok, %PagedResult{success: true}} =
               Activities.list_activities(client,
                 cursor: "MTIzNDU2Nzg5MA==",
                 limit: 50
               )
    end
  end
end

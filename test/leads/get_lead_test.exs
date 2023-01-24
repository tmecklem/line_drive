defmodule LineDrive.Leads.GetLeadTest do
  @moduledoc false
  use LineDrive.PipedriveClientCase

  alias LineDrive.{
    Lead,
    Leads
  }

  describe "get_lead" do
    test "it forms a correct request and returns the correct data structure results for matching lead", %{client: client} do
      assert {:ok, %Lead{id: "d8648e28-debe-45c8-9725-4e742bfbf2c4", title: "Farkel Deal Lead"}} = Leads.get_lead(client, "d8648e28-debe-45c8-9725-4e742bfbf2c4")
    end
  end
end

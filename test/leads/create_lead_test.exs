defmodule LineDrive.Leads.CreateLeadTest do
  @moduledoc false
  use LineDrive.PipedriveClientCase

  alias LineDrive.{
    Lead,
    Leads
  }

  describe "create_lead" do
    test "it forms a correct request and returns the correct data structure results for new lead", %{client: client} do
      assert {:ok, %Lead{id: "d8648e28-debe-45c8-9725-4e742bfbf2c4", title: "Farkel Deal Lead", expected_close_date: nil, person_id: 7, amount: nil}} =
               Leads.create_lead(client, %Lead{title: "Farkel Deal Lead", id: nil, expected_close_date: nil, person_id: 7, amount: "1"})
    end
  end
end

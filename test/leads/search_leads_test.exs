defmodule LineDrive.Leads.SearchLeadsTest do
  @moduledoc false
  use LineDrive.PipedriveClientCase

  alias LineDrive.{
    Lead,
    Leads
  }

  describe "search_leads" do
    test "it forms a correct request and returns the correct data structure results for matching leads",
         %{client: client} do
      assert {:ok,
              [
                %Lead{
                  id: "d8648e28-debe-45c8-9725-4e742bfbf2c4",
                  title: "Farkel Deal Lead",
                  value: 150_000
                }
              ]} = Leads.search_leads(client, "farkel")
    end
  end
end

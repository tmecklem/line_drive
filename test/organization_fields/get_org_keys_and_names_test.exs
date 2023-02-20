defmodule LineDrive.OrganizationFields.GetOrgFieldKeysAndNamesTest do
  @moduledoc false
  use LineDrive.PipedriveClientCase, async: false

  alias LineDrive.{
    OrganizationField,
    OrganizationFields
  }

  describe "get_org_field_keys_and_names" do
    test "it forms a correct request and returns the correct data structure results for matching organization fields",
         %{client: client} do
      assert {:ok,
              [
                %OrganizationField{
                  key: "name",
                  name: "Name"
                },
                %OrganizationField{
                  key: "93fc28f7d5aee87fc6484441cab648760a6c0d2d",
                  name: "Tech Stack"
                }
              ]} = OrganizationFields.get_org_field_keys_and_names(client)
    end
  end
end

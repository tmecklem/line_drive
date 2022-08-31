defmodule LineDrive.Contacts.CreatePersonTest do
  @moduledoc false
  use LineDrive.PipedriveClientCase

  alias LineDrive.{
    Person,
    Persons
  }

  describe "create_persons" do
    test "it forms a correct request and returns the correct data structure results for new person",
         %{client: client} do
      assert {:ok, %Person{id: 1, name: "New Person"}} = Persons.create_person(client, %Person{name: "New Person"})
    end

    # test "with invalid request it returns the error", %{
    #   client: client
    # } do
    #   assert {:error, _error} = HubSpotClient.list_deals(client, limit: -1)
    # end
  end
end

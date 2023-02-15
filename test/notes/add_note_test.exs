defmodule LineDrive.Notes.AddNoteTest do
  @moduledoc false
  use LineDrive.PipedriveClientCase, async: false

  alias LineDrive.{
    Note,
    Notes
  }

  describe "add_note" do
    test "it forms a correct request and returns an added note", %{client: client} do
      expected_attributes = %{
        content: "Met them at such and such event",
        org_id: 1,
        pinned_to_organization_flag: true
      }

      unsaved_note = Note.new(expected_attributes)

      assert {:ok,
              %Note{
                id: 1,
                content: "Met them at such and such event",
                org_id: 1,
                pinned_to_organization_flag: true
              }} = Notes.add_note(client, unsaved_note)
    end
  end
end

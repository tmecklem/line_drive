defmodule LineDrive.FakeNoteApiHandler do
  @moduledoc false

  import Plug.Conn

  def handle_add_note(%{body_params: %{"content" => "Met them at such and such event"}} = conn) do
    response_body = ~s"""
    {
      "success": true,
      "data": {
          "id": 1,
          "user_id": 17120881,
          "deal_id": null,
          "person_id": null,
          "org_id": 1,
          "lead_id": null,
          "content": "Met them at such and such event",
          "add_time": "2023-02-14 21:15:32",
          "update_time": "2023-02-14 21:15:32",
          "active_flag": true,
          "pinned_to_deal_flag": false,
          "pinned_to_person_flag": false,
          "pinned_to_organization_flag": true,
          "pinned_to_lead_flag": false,
          "last_update_user_id": null,
          "organization": {
              "name": "Mecklem, LLC"
          },
          "person": null,
          "deal": null,
          "lead": null,
          "user": {
              "email": "steveloar@launchscout.com",
              "name": "Steve Loar",
              "icon_url": null,
              "is_you": true
          }
      }
    }
    """

    conn
    |> send_resp(201, response_body)
  end
end

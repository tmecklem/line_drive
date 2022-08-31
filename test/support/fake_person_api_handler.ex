defmodule LineDrive.FakePersonApiHandler do
  @moduledoc false

  import Plug.Conn

  def handle_search_persons(conn, %{"term" => "tim"}) do
    response_body = ~s"""
    {
      "success": true,
      "data": {
        "items": [
          {
            "result_score": 0.09985,
            "item": {
              "id": 1,
              "type": "person",
              "name": "Tim Mecklem",
              "phones": [],
              "emails": [],
              "primary_email": null,
              "visible_to": 3,
              "owner": {
                "id": 15783886
              },
              "organization": {
                "id": 1,
                "name": "Mecklem, LLC",
                "address": null
              },
              "custom_fields": [],
              "notes": []
            }
          }
        ]
      },
      "additional_data": {
        "pagination": {
          "start": 0,
          "limit": 50,
          "more_items_in_collection": false
        }
      }
    }
    """

    conn
    |> send_resp(200, response_body)
  end

  def handle_get_person(conn, %{"id" => "1"}) do
    response_body = ~s"""
      {
        "success": true,
        "data": {
          "id": 1,
          "company_id": 11796774,
          "owner_id": {
            "id": 15783886,
            "name": "Tim Mecklem",
            "email": "tim+dev@launchscout.com",
            "has_pic": 0,
            "pic_hash": null,
            "active_flag": true,
            "value": 15783886
          },
          "org_id": {
            "name": "Mecklem, LLC",
            "people_count": 1,
            "owner_id": 15783886,
            "address": null,
            "active_flag": true,
            "cc_email": "launchscout-sandbox@pipedrivemail.com",
            "value": 1
          },
          "name": "Tim Mecklem",
          "first_name": "Tim",
          "last_name": "Mecklem",
          "open_deals_count": 1,
          "related_open_deals_count": 0,
          "closed_deals_count": 0,
          "related_closed_deals_count": 0,
          "participant_open_deals_count": 0,
          "participant_closed_deals_count": 0,
          "email_messages_count": 0,
          "activities_count": 0,
          "done_activities_count": 0,
          "undone_activities_count": 0,
          "files_count": 0,
          "notes_count": 0,
          "followers_count": 1,
          "won_deals_count": 0,
          "related_won_deals_count": 0,
          "lost_deals_count": 0,
          "related_lost_deals_count": 0,
          "active_flag": true,
          "phone": [
            {
              "value": "",
              "primary": true
            }
          ],
          "email": [
            {
              "value": "",
              "primary": true
            }
          ],
          "first_char": "t",
          "update_time": "2022-07-09 15:16:27",
          "add_time": "2022-07-09 15:16:26",
          "visible_to": "3",
          "picture_id": null,
          "next_activity_date": null,
          "next_activity_time": null,
          "next_activity_id": null,
          "last_activity_id": null,
          "last_activity_date": null,
          "last_incoming_mail_time": null,
          "last_outgoing_mail_time": null,
          "label": null,
          "org_name": "Mecklem, LLC",
          "cc_email": "launchscout-sandbox@pipedrivemail.com",
          "primary_email": null,
          "owner_name": "Tim Mecklem"
        },
        "additional_data": {
          "dropbox_email": "launchscout-sandbox@pipedrivemail.com"
        },
        "related_objects": {
          "organization": {
            "1": {
              "id": 1,
              "name": "Mecklem, LLC",
              "people_count": 1,
              "owner_id": 15783886,
              "address": null,
              "active_flag": true,
              "cc_email": "launchscout-sandbox@pipedrivemail.com"
            }
          },
          "user": {
            "15783886": {
              "id": 15783886,
              "name": "Tim Mecklem",
              "email": "tim+dev@launchscout.com",
              "has_pic": 0,
              "pic_hash": null,
              "active_flag": true
            }
          }
        }
      }
    """

    conn
    |> send_resp(200, response_body)
  end

  def handle_create_person(%{body_params: %{"name" => name}} = conn) do
    response_body = ~s"""
      {
        "success": true,
        "data": {
          "id": 1,
          "company_id": 11796774,
          "owner_id": {
            "id": 15783886,
            "name": "Tim Mecklem",
            "email": "tim+dev@launchscout.com",
            "has_pic": 0,
            "pic_hash": null,
            "active_flag": true,
            "value": 15783886
          },
          "org_id": {
            "name": "Mecklem, LLC",
            "people_count": 1,
            "owner_id": 15783886,
            "address": null,
            "active_flag": true,
            "cc_email": "launchscout-sandbox@pipedrivemail.com",
            "value": 1
          },
          "name": "#{name}",
          "first_name": "Tim",
          "last_name": "Mecklem",
          "open_deals_count": 1,
          "related_open_deals_count": 0,
          "closed_deals_count": 0,
          "related_closed_deals_count": 0,
          "participant_open_deals_count": 0,
          "participant_closed_deals_count": 0,
          "email_messages_count": 0,
          "activities_count": 0,
          "done_activities_count": 0,
          "undone_activities_count": 0,
          "files_count": 0,
          "notes_count": 0,
          "followers_count": 1,
          "won_deals_count": 0,
          "related_won_deals_count": 0,
          "lost_deals_count": 0,
          "related_lost_deals_count": 0,
          "active_flag": true,
          "phone": [
            {
              "value": "",
              "primary": true
            }
          ],
          "email": [
            {
              "value": "",
              "primary": true
            }
          ],
          "first_char": "t",
          "update_time": "2022-07-09 15:16:27",
          "add_time": "2022-07-09 15:16:26",
          "visible_to": "3",
          "picture_id": null,
          "next_activity_date": null,
          "next_activity_time": null,
          "next_activity_id": null,
          "last_activity_id": null,
          "last_activity_date": null,
          "last_incoming_mail_time": null,
          "last_outgoing_mail_time": null,
          "label": null,
          "org_name": "Mecklem, LLC",
          "cc_email": "launchscout-sandbox@pipedrivemail.com",
          "primary_email": null,
          "owner_name": "Tim Mecklem"
        },
        "additional_data": {
          "dropbox_email": "launchscout-sandbox@pipedrivemail.com"
        },
        "related_objects": {
          "organization": {
            "1": {
              "id": 1,
              "name": "Mecklem, LLC",
              "people_count": 1,
              "owner_id": 15783886,
              "address": null,
              "active_flag": true,
              "cc_email": "launchscout-sandbox@pipedrivemail.com"
            }
          },
          "user": {
            "15783886": {
              "id": 15783886,
              "name": "Tim Mecklem",
              "email": "tim+dev@launchscout.com",
              "has_pic": 0,
              "pic_hash": null,
              "active_flag": true
            }
          }
        }
      }
    """

    conn
    |> send_resp(201, response_body)
  end
end

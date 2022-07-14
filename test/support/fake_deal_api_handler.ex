defmodule LineDrive.FakeDealApiHandler do
  @moduledoc false

  import Plug.Conn

  def handle_get_deal(conn, %{"id" => "1"}) do
    response_body = ~s"""
    {
      "success": true,
      "data": {
        "id": 1,
        "creator_user_id": {
          "id": 15783886,
          "name": "Tim Mecklem",
          "email": "tim+dev@launchscout.com",
          "has_pic": 0,
          "pic_hash": null,
          "active_flag": true,
          "value": 15783886
        },
        "user_id": {
          "id": 15783886,
          "name": "Tim Mecklem",
          "email": "tim+dev@launchscout.com",
          "has_pic": 0,
          "pic_hash": null,
          "active_flag": true,
          "value": 15783886
        },
        "person_id": {
          "active_flag": true,
          "name": "Tim Mecklem",
          "email": [
            {
              "value": "",
              "primary": true
            }
          ],
          "phone": [
            {
              "value": "",
              "primary": true
            }
          ],
          "owner_id": 15783886,
          "value": 1
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
        "stage_id": 2,
        "title": "Mecklem, LLC deal",
        "value": 30000,
        "currency": "USD",
        "add_time": "2022-07-09 15:16:27",
        "update_time": "2022-07-09 15:16:27",
        "stage_change_time": null,
        "active": true,
        "deleted": false,
        "status": "open",
        "probability": null,
        "next_activity_date": null,
        "next_activity_time": null,
        "next_activity_id": null,
        "last_activity_id": null,
        "last_activity_date": null,
        "lost_reason": null,
        "visible_to": "3",
        "close_time": null,
        "pipeline_id": 1,
        "won_time": null,
        "first_won_time": null,
        "lost_time": null,
        "products_count": 0,
        "files_count": 0,
        "notes_count": 0,
        "followers_count": 1,
        "email_messages_count": 0,
        "activities_count": 0,
        "done_activities_count": 0,
        "undone_activities_count": 0,
        "participants_count": 1,
        "expected_close_date": "2022-07-21",
        "last_incoming_mail_time": null,
        "last_outgoing_mail_time": null,
        "label": null,
        "renewal_type": "one_time",
        "stage_order_nr": 1,
        "person_name": "Tim Mecklem",
        "org_name": "Mecklem, LLC",
        "next_activity_subject": null,
        "next_activity_type": null,
        "next_activity_duration": null,
        "next_activity_note": null,
        "group_id": null,
        "group_name": null,
        "formatted_value": "$30,000",
        "weighted_value": 30000,
        "formatted_weighted_value": "$30,000",
        "weighted_value_currency": "USD",
        "rotten_time": null,
        "owner_name": "Tim Mecklem",
        "cc_email": "launchscout-sandbox+deal1@pipedrivemail.com",
        "org_hidden": false,
        "person_hidden": false,
        "average_time_to_won": {
          "y": 0,
          "m": 0,
          "d": 0,
          "h": 0,
          "i": 0,
          "s": 0,
          "total_seconds": 0
        },
        "average_stage_progress": 0,
        "age": {
          "y": 0,
          "m": 0,
          "d": 0,
          "h": 11,
          "i": 21,
          "s": 21,
          "total_seconds": 40881
        },
        "stay_in_pipeline_stages": {
          "times_in_stages": {
            "1": 0,
            "2": 40881
          },
          "order_of_stages": [
            1,
            2
          ]
        },
        "last_activity": null,
        "next_activity": null
      },
      "additional_data": {
        "dropbox_email": "launchscout-sandbox+deal1@pipedrivemail.com"
      },
      "related_objects": {
        "user": {
          "15783886": {
            "id": 15783886,
            "name": "Tim Mecklem",
            "email": "tim+dev@launchscout.com",
            "has_pic": 0,
            "pic_hash": null,
            "active_flag": true
          }
        },
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
        "person": {
          "1": {
            "active_flag": true,
            "id": 1,
            "name": "Tim Mecklem",
            "email": [
              {
                "value": "",
                "primary": true
              }
            ],
            "phone": [
              {
                "value": "",
                "primary": true
              }
            ],
            "owner_id": 15783886
          }
        }
      }
    }
    """

    conn
    |> send_resp(200, response_body)
  end

  def handle_search_deals(conn, %{"term" => _term}) do
    response_body = ~s"""
    {
      "success": true,
      "data": {
        "items": [
          {
            "result_score": 1.092828,
            "item": {
              "id": 2,
              "type": "deal",
              "title": "Great Amazing Deal",
              "value": 40000,
              "currency": "USD",
              "status": "open",
              "visible_to": 3,
              "owner": {
                "id": 15783886
              },
              "stage": {
                "id": 7,
                "name": "Qualified"
              },
              "person": {
                "id": 1,
                "name": "Tim Mecklem"
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
          "limit": 25,
          "more_items_in_collection": false
        }
      }
    }
    """

    conn
    |> send_resp(200, response_body)
  end
end

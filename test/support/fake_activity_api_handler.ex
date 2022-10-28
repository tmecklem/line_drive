defmodule LineDrive.FakeActivityApiHandler do
  @moduledoc false

  import Plug.Conn

  alias LineDrive.Activity

  def handle_add_activity(%{body_params: activity_map} = conn) do
    activity = Activity.new(activity_map |> Map.new(fn {k, v} -> {String.to_atom(k), v} end))

    response_body = ~s"""
    {
      "success": true,
      "data": {
        "id": 2,
        "company_id": 11796774,
        "user_id": 15783886,
        "done": #{activity.done || 0},
        "type": "#{activity.type || "Call"}",
        "reference_type": null,
        "reference_id": null,
        "conference_meeting_client": null,
        "conference_meeting_url": null,
        "due_date": "#{Timex.format!(activity.due_date, "%Y-%m-%d", :strftime)}",
        "due_time": "#{activity.due_time}",
        "busy_flag": #{activity.busy_flag},
        "add_time": "2022-07-15 21:14:14",
        "marked_as_done_time": "2022-07-15 21:14:14",
        "last_notification_time": null,
        "last_notification_user_id": null,
        "notification_language_id": null,
        "subject": "#{activity.subject}",
        "public_description": "#{activity.public_description}",
        "calendar_sync_include_context": null,
        "location": "location",
        "org_id": 1,
        "person_id": 1,
        "deal_id": #{activity.deal_id},
        "active_flag": true,
        "update_time": "2022-07-15 21:14:14",
        "update_user_id": null,
        "source_timezone": null,
        "rec_rule": null,
        "rec_rule_extension": null,
        "rec_master_activity_id": null,
        "conference_meeting_id": null,
        "note": "#{activity.note}",
        "created_by_user_id": 15783886,
        "location_subpremise": null,
        "location_street_number": null,
        "location_route": null,
        "location_sublocality": null,
        "location_locality": null,
        "location_admin_area_level_1": null,
        "location_admin_area_level_2": null,
        "location_country": null,
        "location_postal_code": null,
        "location_formatted_address": null,
        "attendees": null,
        "series": null,
        "is_recurring": null,
        "org_name": "Mecklem, LLC",
        "person_name": "Tim Mecklem",
        "deal_title": "Mecklem, LLC deal",
        "lead_title": null,
        "owner_name": "Tim Mecklem",
        "person_dropbox_bcc": "launchscoot-sandbox@pipedrivemail.com",
        "deal_dropbox_bcc": "launchscoot-sandbox+deal1@pipedrivemail.com",
        "assigned_to_user_id": 15783886,
        "type_name": "Call",
        "lead": null
      },
      "additional_data": {
        "more_activities_scheduled_in_context": false,
        "updates_story_id": 10
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
            "cc_email": "launchscoot-sandbox@pipedrivemail.com"
          }
        },
        "person": {
          "1": {
            "active_flag": true,
            "id": 1,
            "name": "Tim Mecklem",
            "email": [
              {
                "label": "work",
                "value": "tim@launchscoot.com",
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
          },
          "2": {
            "active_flag": true,
            "id": 2,
            "name": "Tina Marcklem",
            "email": [
              {
                "label": "work",
                "value": "tina.marklem@test.example",
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
        },
        "deal": {
          "1": {
            "id": 1,
            "title": "Mecklem, LLC deal",
            "status": "open",
            "value": 30000,
            "currency": "USD",
            "stage_id": 2,
            "pipeline_id": 1
          }
        },
        "user": {
          "15783886": {
            "id": 15783886,
            "name": "Tim Mecklem",
            "email": "tim+dev@launchscoot.com",
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

  def handle_list_activities(%{params: _params} = conn) do
    response_body = ~s"""
    {
      "success": true,
      "data": [
        {
          "id": 1,
          "company_id": 11796774,
          "user_id": 15783886,
          "done": false,
          "type": "meeting",
          "reference_type": null,
          "reference_id": null,
          "conference_meeting_client": null,
          "conference_meeting_url": null,
          "due_date": "2022-07-15",
          "due_time": "",
          "duration": "",
          "busy_flag": null,
          "add_time": "2022-07-15 04:14:57",
          "marked_as_done_time": "",
          "last_notification_time": null,
          "last_notification_user_id": null,
          "notification_language_id": null,
          "subject": "Meeting",
          "public_description": "",
          "calendar_sync_include_context": null,
          "location": null,
          "org_id": null,
          "person_id": 3,
          "deal_id": null,
          "lead_id": null,
          "project_id": null,
          "active_flag": true,
          "update_time": "2022-07-15 04:20:59",
          "update_user_id": 15783886,
          "source_timezone": null,
          "rec_rule": null,
          "rec_rule_extension": null,
          "rec_master_activity_id": null,
          "conference_meeting_id": null,
          "original_start_time": null,
          "note": null,
          "created_by_user_id": 15783886,
          "location_subpremise": null,
          "location_street_number": null,
          "location_route": null,
          "location_sublocality": null,
          "location_locality": null,
          "location_admin_area_level_1": null,
          "location_admin_area_level_2": null,
          "location_country": null,
          "location_postal_code": null,
          "location_formatted_address": null,
          "attendees": null,
          "participants": [
            {
              "person_id": 2,
              "primary_flag": false
            },
            {
              "person_id": 3,
              "primary_flag": true
            }
          ],
          "series": null,
          "is_recurring": null,
          "org_name": null,
          "person_name": "Scott Wiggins",
          "deal_title": null,
          "lead_title": null,
          "project_title": null,
          "owner_name": "Tim Mecklem",
          "person_dropbox_bcc": "launchscoot-sandbox-tim@pipedrivemail.com",
          "deal_dropbox_bcc": null,
          "assigned_to_user_id": 15783886,
          "type_name": "Meeting",
          "lead": null
        },
        {
          "id": 4,
          "company_id": 11796774,
          "user_id": 15783886,
          "done": false,
          "type": "task",
          "reference_type": null,
          "reference_id": null,
          "conference_meeting_client": null,
          "conference_meeting_url": null,
          "due_date": "2022-07-18",
          "due_time": "",
          "duration": "",
          "busy_flag": false,
          "add_time": "2022-07-18 21:34:25",
          "marked_as_done_time": "",
          "last_notification_time": null,
          "last_notification_user_id": null,
          "notification_language_id": null,
          "subject": "This is a test subject",
          "public_description": "",
          "calendar_sync_include_context": null,
          "location": null,
          "org_id": null,
          "person_id": null,
          "deal_id": null,
          "lead_id": null,
          "project_id": null,
          "active_flag": true,
          "update_time": "2022-07-18 21:34:25",
          "update_user_id": null,
          "source_timezone": null,
          "rec_rule": null,
          "rec_rule_extension": null,
          "rec_master_activity_id": null,
          "conference_meeting_id": null,
          "original_start_time": null,
          "note": null,
          "created_by_user_id": 15783886,
          "location_subpremise": null,
          "location_street_number": null,
          "location_route": null,
          "location_sublocality": null,
          "location_locality": null,
          "location_admin_area_level_1": null,
          "location_admin_area_level_2": null,
          "location_country": null,
          "location_postal_code": null,
          "location_formatted_address": null,
          "attendees": null,
          "participants": null,
          "series": null,
          "is_recurring": null,
          "org_name": null,
          "person_name": null,
          "deal_title": null,
          "lead_title": null,
          "project_title": null,
          "owner_name": "Tim Mecklem",
          "person_dropbox_bcc": null,
          "deal_dropbox_bcc": null,
          "assigned_to_user_id": 15783886,
          "type_name": "Task",
          "lead": null
        }
      ],
      "additional_data": {
        "pagination": {
          "start": 0,
          "limit": 500,
          "more_items_in_collection": false
        }
      },
      "related_objects": {
        "user": {
          "15783886": {
            "id": 15783886,
            "name": "Tim Mecklem",
            "email": "tim+dev@launchscoot.com",
            "has_pic": 0,
            "pic_hash": null,
            "active_flag": true
          }
        },
        "person": {
          "2": {
            "id": 2,
            "name": "Tina Marcklem",
            "email": [
              {
                "label": "work",
                "value": "tina.marklem@test.example",
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
          },
          "3": {
            "id": 3,
            "name": "Scott Wiggins",
            "email": [
              {
                "label": "work",
                "value": "scott@launchscoot.com",
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
end

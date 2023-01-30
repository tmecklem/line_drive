defmodule LineDrive.FakeOrganizationApiHandler do
  @moduledoc false

  import Plug.Conn

  def handle_get_organization(conn, %{"id" => "1"}) do
    response_body = ~s"""
    {
      "success": true,
      "data": {
          "id": 1,
          "company_id": 12656204,
          "owner_id": {
              "id": 17269766,
              "name": "Al",
              "email": "al+pipedrive@launchscout.com",
              "has_pic": 0,
              "pic_hash": null,
              "active_flag": true,
              "value": 17269766
          },
          "name": "An Org",
          "open_deals_count": 1,
          "related_open_deals_count": 0,
          "closed_deals_count": 0,
          "related_closed_deals_count": 0,
          "email_messages_count": 0,
          "people_count": 0,
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
          "category_id": null,
          "picture_id": null,
          "country_code": null,
          "first_char": "a",
          "update_time": "2023-01-18 21:35:54",
          "delete_time": null,
          "add_time": "2023-01-18 21:35:54",
          "visible_to": "3",
          "next_activity_date": null,
          "next_activity_time": null,
          "next_activity_id": null,
          "last_activity_id": null,
          "last_activity_date": null,
          "label": null,
          "address": null,
          "address_subpremise": null,
          "address_street_number": null,
          "address_route": null,
          "address_sublocality": null,
          "address_locality": null,
          "address_admin_area_level_1": null,
          "address_admin_area_level_2": null,
          "address_country": null,
          "address_postal_code": null,
          "address_formatted_address": null,
          "cc_email": "launchscout-sandbox+deal1@pipedrivemail.com",
          "owner_name": "Al",
          "edit_name": true,
          "last_activity": null,
          "next_activity": null
      },
      "additional_data": {
          "followers": {
              "17269766": {
                  "name": "Al",
                  "email": "launchscout-sandbox+deal1@pipedrivemail.com",
                  "user_id": 17269766,
                  "pic_hash": null,
                  "id": 1
              }
          },
          "dropbox_email": "launchscout-sandbox+deal1@pipedrivemail.com"
      },
      "related_objects": {
          "user": {
              "17269766": {
                  "id": 17269766,
                  "name": "Al",
                  "email": "al+pipedrive@launchscout.com",
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

  def handle_create_organization(%{body_params: %{"name" => _name}} = conn) do
    response_body = ~s"""
    {
      "success": true,
      "data": {
          "id": 1,
          "company_id": 12656204,
          "owner_id": {
              "id": 17269766,
              "name": "Al",
              "email": "al+pipedrive@launchscout.com",
              "has_pic": 0,
              "pic_hash": null,
              "active_flag": true,
              "value": 17269766
          },
          "name": "New Org",
          "open_deals_count": 0,
          "related_open_deals_count": 0,
          "closed_deals_count": 0,
          "related_closed_deals_count": 0,
          "email_messages_count": 0,
          "people_count": 0,
          "activities_count": 0,
          "done_activities_count": 0,
          "undone_activities_count": 0,
          "files_count": 0,
          "notes_count": 0,
          "followers_count": 0,
          "won_deals_count": 0,
          "related_won_deals_count": 0,
          "lost_deals_count": 0,
          "related_lost_deals_count": 0,
          "active_flag": true,
          "category_id": null,
          "picture_id": null,
          "country_code": null,
          "first_char": "n",
          "update_time": "2023-01-30 15:56:17",
          "delete_time": null,
          "add_time": "2023-01-30 15:56:16",
          "visible_to": "3",
          "next_activity_date": null,
          "next_activity_time": null,
          "next_activity_id": null,
          "last_activity_id": null,
          "last_activity_date": null,
          "label": null,
          "address": null,
          "address_subpremise": null,
          "address_street_number": null,
          "address_route": null,
          "address_sublocality": null,
          "address_locality": null,
          "address_admin_area_level_1": null,
          "address_admin_area_level_2": null,
          "address_country": null,
          "address_postal_code": null,
          "address_formatted_address": null,
          "cc_email": "al-sandbox@pipedrivemail.com",
          "owner_name": "Al",
          "edit_name": true
      },
      "related_objects": {
          "user": {
              "17269766": {
                  "id": 17269766,
                  "name": "Al",
                  "email": "al+pipedrive@launchscout.com",
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

  def handle_search_organizations(conn, %{"term" => _term}) do
    response_body = ~s"""
    {
      "success": true,
      "data": {
          "items": [
              {
                  "result_score": 0.35513002,
                  "item": {
                      "id": 2,
                      "type": "organization",
                      "name": "Great Amazing Organization",
                      "address": null,
                      "visible_to": 3,
                      "owner": {
                          "id": 17269766
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
end

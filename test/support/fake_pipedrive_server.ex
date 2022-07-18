defmodule LineDrive.FakePipedriveServer do
  @moduledoc """
  Fake (yet also real HTTP) server to handle requests that conform to
  pipedrive's api and return responses that look like real pipedrive responses.
  """

  use Plug.Router

  import LineDrive.{
    FakeActivityApiHandler,
    FakeActivityTypeApiHandler,
    FakeDealApiHandler,
    FakePersonApiHandler,
    FakePipelineApiHandler
  }

  plug(:match)

  plug(Plug.Parsers,
    parsers: [:json],
    pass: ["application/json"],
    json_decoder: Jason
  )

  plug(:dispatch)

  post "/api/v1/activities" do
    conn
    |> put_resp_header("content-type", "application/json;charset=utf-8")
    |> handle_add_activity()
  end

  get "/api/v1/activityTypes" do
    conn
    |> put_resp_header("content-type", "application/json;charset=utf-8")
    |> handle_list_activity_types()
  end

  get "/api/v1/deals/search" do
    conn
    |> put_resp_header("content-type", "application/json;charset=utf-8")
    |> handle_search_deals(conn.query_params)
  end

  get "/api/v1/deals/:id" do
    conn
    |> put_resp_header("content-type", "application/json;charset=utf-8")
    |> handle_get_deal(conn.params)
  end

  get "/api/v1/persons/search" do
    conn
    |> put_resp_header("content-type", "application/json;charset=utf-8")
    |> handle_search_persons(conn.query_params)
  end

  get "/api/v1/persons/:id" do
    conn
    |> put_resp_header("content-type", "application/json;charset=utf-8")
    |> handle_get_person(conn.params)
  end

  get "/api/v1/pipelines/:id/deals" do
    conn
    |> put_resp_header("content-type", "application/json;charset=utf-8")
    |> handle_list_pipeline_deals(conn.query_params)
  end

  get "/api/v1/pipelines" do
    conn
    |> put_resp_header("content-type", "application/json;charset=utf-8")
    |> handle_list_pipelines()
  end

  match _ do
    send_resp(conn, 404, "oops")
  end
end

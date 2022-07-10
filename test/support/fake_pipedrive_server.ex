defmodule LineDrive.FakePipedriveServer do
  @moduledoc """
  Fake (yet also real HTTP) server to handle requests that conform to
  pipedrive's api and return responses that look like real pipedrive responses.
  """

  use Plug.Router

  import LineDrive.FakeDealApiHandler

  plug(:match)

  plug(Plug.Parsers,
    parsers: [:json],
    pass: ["application/json"],
    json_decoder: Jason
  )

  plug(:dispatch)

  get "/api/v1/deals" do
    conn
    |> put_resp_header("content-type", "application/json;charset=utf-8")
    |> handle_get_deal(conn.query_params)
  end

  match _ do
    send_resp(conn, 404, "oops")
  end
end

defmodule LineDrive.Incoming.Handler do
  @moduledoc """
  This plug handles incoming webhook POSTs from Pipedrive and converts them into
  events published via the Registry.

  To subscribe to a particular event (such as updated deals in the following
  example), use:
  `Registry.register(Registry.LineDriveEvents, :updated_deal, [])`

  You will then need to implement a `handle_info({:updated_deal, payload})`,
  where the payload varies by event type. See
  https://pipedrive.readme.io/docs/guide-for-webhooks for more information about
  possible event types and the expected payloads for each.
  """

  use LineDrive.Incoming.DealHandler
  use Plug.Router

  require Logger

  plug(:match)
  plug(:dispatch)

  plug(Plug.Parsers,
    parsers: [:json],
    json_decoder: Jason
  )

  def init(opts), do: opts

  def call(conn, opts) do
    conn = Plug.BasicAuth.basic_auth(conn, opts)

    super(conn, opts)
  end

  post "/webhook" do
    conn.body_params
    |> process_event()
    |> notify_subscribers()

    send_resp(conn, 200, "")
  end

  match _ do
    send_resp(conn, 404, "")
  end

  def process_event(%{"event" => event_type} = payload) do
    transform_event(event_type, payload)
  end

  def transform_event(_, payload) do
    Logger.warn("Unhandled incoming event: #{inspect(payload)}")

    nil
  end

  defp notify_subscribers(nil), do: nil

  defp notify_subscribers({event_type, message}) do
    Logger.warn("Dispatching event: #{inspect(event_type)}")

    Registry.dispatch(Registry.LineDriveEvents, event_type, fn entries ->
      for {pid, _} <- entries, do: send(pid, {event_type, message})
    end)
  end
end

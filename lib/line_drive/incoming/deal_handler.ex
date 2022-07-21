defmodule LineDrive.Incoming.DealHandler do
  @moduledoc """
  Payload handler for incoming deal-related webhook events. This module
  transforms the JSON into `LineDrive.Deal` and related structs and returns a
  tuple with the event_type (eg `updated_deal`) and transformed payload.
  """

  alias LineDrive.Deal

  defmacro __using__(_opts) do
    quote do
      import LineDrive.Incoming.DealHandler, only: [deal_updated: 1]

      def transform_event("updated.deal", payload) do
        deal_updated(payload)
      end
    end
  end

  def deal_updated(%{"current" => deal, "meta" => meta, "previous" => previous_deal}) do
    {:updated_deal, %{current: Deal.new(deal), previous: Deal.new(previous_deal), meta: meta}}
  end
end

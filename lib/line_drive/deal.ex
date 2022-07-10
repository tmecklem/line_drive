defmodule LineDrive.Deal do
  @moduledoc """
  This module and enclosed struct represent a deal in pipedrive.
  """

  @type t :: %__MODULE__{
          expected_close_date: Date.t(),
          id: integer,
          pipeline_id: integer,
          stage_id: integer,
          status: binary(),
          title: binary(),
          value: float() | nil,
          weighted_value: float() | nil
        }

  @keys [
    :expected_close_date,
    :id,
    :pipeline_id,
    :stage_id,
    :status,
    :title,
    :value,
    :weighted_value
  ]
  @enforce_keys @keys
  defstruct @keys

  def new(map) do
    struct(
      __MODULE__,
      map
      |> Map.put(:expected_close_date, parse_date(map.expected_close_date))
    )
  end

  defp parse_date(nil), do: nil

  defp parse_date(date_str) do
    case Date.from_iso8601(date_str) do
      {:ok, date} -> date
      _ -> nil
    end
  end
end

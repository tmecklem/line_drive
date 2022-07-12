defmodule LineDrive.Pipeline do
  @moduledoc """
  This module and enclosed struct represent a pipeline in pipedrive.
  """

  @type t :: %__MODULE__{
          active: boolean,
          add_time: NaiveDateTime.t(),
          deal_probability: boolean,
          id: integer,
          name: binary(),
          order_nr: integer,
          selected: boolean,
          update_time: NaiveDateTime.t() | nil,
          url_title: binary()
        }

  @keys [
    :active,
    :add_time,
    :deal_probability,
    :id,
    :name,
    :order_nr,
    :selected,
    :update_time,
    :url_title
  ]
  @enforce_keys @keys
  defstruct @keys

  def new(map) do
    struct(
      __MODULE__,
      map
      |> Map.put(:add_time, parse_naivedatetime(map.add_time))
      |> Map.put(:update_time, parse_naivedatetime(map.update_time))
    )
  end

  defp parse_naivedatetime(nil), do: nil

  defp parse_naivedatetime(date_str) do
    case NaiveDateTime.from_iso8601(date_str) do
      {:ok, date} -> date
      _ -> nil
    end
  end
end

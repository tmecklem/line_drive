defmodule LineDrive.ActivityType do
  @moduledoc """
  This module and enclosed struct represent a activity type in pipedrive.
  """

  @type t :: %__MODULE__{
          active_flag: boolean,
          add_time: NaiveDateTime.t() | nil,
          id: integer,
          is_custom_flag: boolean(),
          key_string: binary(),
          name: binary(),
          update_time: NaiveDateTime.t() | nil
        }

  @keys [
    :active_flag,
    :add_time,
    :id,
    :is_custom_flag,
    :key_string,
    :name,
    :update_time
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

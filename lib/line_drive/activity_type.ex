defmodule LineDrive.ActivityType do
  @moduledoc """
  This module and enclosed struct represent a activity type in pipedrive.
  """

  use TypedStruct

  @type key_string :: binary()

  typedstruct enforce: true do
    field :active_flag, boolean()
    field :add_time, NaiveDateTime.t()
    field :id, pos_integer()
    field :is_custom_flag, boolean()
    field :key_string, key_string()
    field :name, String.t()
    field :update_time, NaiveDateTime.t()
  end

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

defmodule LineDrive.Pipeline do
  @moduledoc """
  This module and enclosed struct represent a pipeline in pipedrive.
  """

  use TypedStruct

  typedstruct enforce: true do
    field :active, boolean()
    field :add_time, NaiveDateTime.t()
    field :deal_probability, float()
    field :id, pos_integer()
    field :name, String.t()
    field :order_nr, pos_integer()
    field :selected, boolean()
    field :update_time, NaiveDateTime.t()
    field :url_title, String.t()
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

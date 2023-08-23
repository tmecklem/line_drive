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
    map
    |> atomize_keys()
    |> Map.update(:add_time, nil, &parse_datetime/1)
    |> Map.update(:update_time, nil, &parse_datetime/1)
    |> then(&struct(__MODULE__, &1))
  end

  defp atomize_keys(map) do
    struct_keys()
    |> Enum.reduce(%{}, fn key, acc ->
      Map.put(acc, key, Map.get_lazy(map, key, fn -> Map.get(map, Atom.to_string(key), nil) end))
    end)
  end

  defp parse_datetime(nil), do: nil

  defp parse_datetime(date_str) do
    case NaiveDateTime.from_iso8601(date_str) do
      {:ok, date} -> date
      _ -> nil
    end
  end

  defp struct_keys do
    Map.keys(__MODULE__.__struct__())
    |> List.delete(:__struct__)
  end
end

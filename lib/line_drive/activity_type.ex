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
    map
    |> atomize_keys()
    |> Map.update(:add_time, nil, &parse_naivedatetime/1)
    |> Map.update(:update_time, nil, &parse_naivedatetime/1)
    |> then(&struct(__MODULE__, &1))
  end

  defp parse_naivedatetime(nil), do: nil

  defp parse_naivedatetime(date_str) do
    case NaiveDateTime.from_iso8601(date_str) do
      {:ok, date} -> date
      _ -> nil
    end
  end

  defp atomize_keys(map) do
    struct_keys()
    |> Enum.reduce(%{}, fn key, acc ->
      Map.put(acc, key, Map.get_lazy(map, key, fn -> Map.get(map, Atom.to_string(key), nil) end))
    end)
  end

  defp struct_keys do
    Map.keys(__MODULE__.__struct__())
    |> List.delete(:__struct__)
  end
end

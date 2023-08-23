defmodule LineDrive.LeadOrganization do
  @moduledoc """
  This module represent a lead organization in pipedrive.
  """
  use TypedStruct

  typedstruct do
    field :id, pos_integer()
    field :name, String.t()
  end

  def new(nil), do: nil

  def new(map) do
    map
    |> atomize_keys()
    |> then(&struct(__MODULE__, &1))
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

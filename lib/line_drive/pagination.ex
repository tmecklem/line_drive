defmodule LineDrive.Pagination do
  @moduledoc """
  This module and enclosed structs represent pagination metadatafrom pipedrive.
  """

  use TypedStruct

  typedstruct do
    field :start, non_neg_integer()
    field :limit, non_neg_integer()
    field :more_items_in_collection, boolean()
  end

  def new(map) do
    struct(__MODULE__, atomize_keys(map))
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

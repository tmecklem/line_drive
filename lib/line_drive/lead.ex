defmodule LineDrive.Lead do
  @moduledoc """
  This module and enclosed struct represent a lead in pipedrive.
  """

  use TypedStruct

  typedstruct enforce: true do
    field :expected_close_date, Date.t()
    field :id, String.t()
    field :title, String.t()
    field :person_id, pos_integer()
    field :amount, float()
  end

  defimpl Jason.Encoder, for: __MODULE__ do
    def encode(%{id: nil} = lead, opts) do
      Jason.Encode.value(Map.take(Map.from_struct(lead), [:title, :id, :person_id, :amount, :expected_close_date]), opts)
    end

    def encode(lead, opts), do: Jason.encode(lead, opts)
  end

  def new(map) do
    struct(
      __MODULE__, 
      Map.update(atomize_keys(map), :expected_close_date, nil, &parse_date/1))
  end

  defp atomize_keys(map) do
    struct_keys()
    |> Enum.reduce(%{}, fn key, acc ->
      Map.put(acc, key, Map.get_lazy(map, key, fn -> Map.get(map, Atom.to_string(key), nil) end))
    end)
  end

  defp parse_date(nil), do: nil

  defp parse_date(date_str) do
    case Date.from_iso8601(date_str) do
      {:ok, date} -> date
      _ -> nil
    end
  end

  defp struct_keys do
    @enforce_keys
  end
end

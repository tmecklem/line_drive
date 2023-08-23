defmodule LineDrive.Lead do
  @moduledoc """
  This module and enclosed structs represent a lead in pipedrive.
  """

  use TypedStruct

  alias LineDrive.{LeadOrganization, LeadPerson, LeadValue}

  typedstruct do
    field :expected_close_date, Date.t()
    field :person_id, pos_integer()
    field :person, LeadPerson
    field :organization_id, pos_integer()
    field :organization, LeadOrganization
    field :title, String.t(), enforce: true
    field :value, LeadValue
    field :id, String.t()
  end

  defimpl Jason.Encoder, for: __MODULE__ do
    def encode(%{} = lead, opts) do
      Jason.Encode.value(
        Map.take(Map.from_struct(lead), [
          :title,
          :person_id,
          :organization_id,
          :value,
          :expected_close_date
        ]),
        opts
      )
    end

    def encode(lead, opts), do: Jason.encode(lead, opts)
  end

  def new(map) do
    map
    |> atomize_keys()
    |> Map.update(:expected_close_date, nil, &parse_date/1)
    |> Map.update(:organization, nil, &LeadOrganization.new/1)
    |> Map.update(:person, nil, &LeadPerson.new/1)
    |> Map.update(:value, nil, &LeadValue.new/1)
    |> then(&struct(__MODULE__, &1))
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
    Map.keys(__MODULE__.__struct__())
    |> List.delete(:__struct__)
  end
end

defmodule LineDrive.Lead do
  @moduledoc """
  This module and enclosed structs represent a lead in pipedrive.
  """

  use TypedStruct
  use LineDrive.Structable

  alias LineDrive.LeadOrganization
  alias LineDrive.LeadPerson
  alias LineDrive.LeadValue

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

  def handle_transform(map, _) do
    map
    |> Map.update(:expected_close_date, nil, &parse_date/1)
    |> Map.update(:organization, nil, &LeadOrganization.new/1)
    |> Map.update(:person, nil, &LeadPerson.new/1)
    |> Map.update(:value, nil, &LeadValue.new/1)
  end
end

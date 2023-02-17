defmodule LineDrive.Note do
  @moduledoc """
  This module and enclosed structs represent a note in pipedrive.
  """

  use TypedStruct

  typedstruct do
    field :content, String.t(), enforce: true
    field :id, String.t()
    field :org_id, pos_integer()
    field :person_id, pos_integer()
    field :deal_id, pos_integer()
    field :lead_id, pos_integer()
    field :pinned_to_organization_flag, boolean(), default: false
  end

  defimpl Jason.Encoder, for: __MODULE__ do
    def encode(%{} = note, opts) do
      Jason.Encode.value(
        Map.take(Map.from_struct(note), [
          :content,
          :org_id,
          :person_id,
          :deal_id,
          :lead_id,
          :pinned_to_organization_flag
        ]),
        opts
      )
    end

    def encode(note, opts), do: Jason.encode(note, opts)
  end

  def new(map) do
    struct(
      __MODULE__,
      map
    )
  end
end

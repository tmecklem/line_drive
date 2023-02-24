defmodule LineDrive.OrganizationField do
  @moduledoc """
  This module and enclosed structs represent an organization field in pipedrive.
  """

  use TypedStruct

  typedstruct do
    field :key, String.t()
    field :name, String.t()
  end

  defimpl Jason.Encoder, for: __MODULE__ do
    def encode(%{} = organization_field, opts) do
      Jason.Encode.value(
        Map.take(Map.from_struct(organization_field), [
          :key,
          :name
        ]),
        opts
      )
    end

    def encode(organization_field, opts), do: Jason.encode(organization_field, opts)
  end

  def new(map) do
    struct(
      __MODULE__,
      map
    )
  end
end

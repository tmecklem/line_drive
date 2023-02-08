defmodule LineDrive.Organization do
  @moduledoc """
  This module and enclosed struct represent an organization in pipedrive.
  """

  use TypedStruct

  typedstruct do
    field :id, pos_integer()
    field :name, String.t(), enforce: true
    field :owner_id, pos_integer()
  end

  defimpl Jason.Encoder, for: __MODULE__ do
    def encode(%{id: nil} = org, opts) do
      Jason.Encode.value(Map.take(Map.from_struct(org), [:name, :owner_id]), opts)
    end

    def encode(org, opts), do: Jason.encode(org, opts)
  end

  def new(map) do
    struct(__MODULE__, map)
  end
end

defmodule LineDrive.Person do
  @moduledoc """
  This module and enclosed struct represent a person in pipedrive.
  """

  use TypedStruct

  typedstruct do
    field :id, pos_integer()
    field :name, String.t(), enforce: true
    field :primary_email, String.t()
  end

  defimpl Jason.Encoder, for: __MODULE__ do
    def encode(%{id: nil} = person, opts) do
      Jason.Encode.value(Map.take(Map.from_struct(person), [:name]), opts)
    end

    def encode(person, opts), do: Jason.encode(person, opts)
  end

  def new(map) do
    struct(__MODULE__, map)
  end
end

defmodule LineDrive.Person do
  @moduledoc """
  This module and enclosed struct represent a person in pipedrive.
  """

  use TypedStruct

  typedstruct do
    field :id, pos_integer()
    field :name, String.t(), enforce: true
    field :owner_id, pos_integer()
    field :primary_email, String.t()
    # search returns an organization map
    field :organization, LineDrive.Organization.t()
    field :org_name, String.t()
    field :org_id, pos_integer()
  end

  defimpl Jason.Encoder, for: __MODULE__ do
    def encode(%{id: nil} = person, opts) do
      Jason.Encode.value(Map.take(Map.from_struct(person), [:name, :owner_id]), opts)
    end

    def encode(person, opts), do: Jason.encode(person, opts)
  end

  def new(map) do
    org =
      map
      |> Map.get(:organization, %{})
      |> Kernel.||(%{})
      |> LineDrive.Organization.new()

    map = Map.put(map, :organization, org)
    struct(__MODULE__, map)
  end
end

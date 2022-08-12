defmodule LineDrive.Person do
  @moduledoc """
  This module and enclosed struct represent a person in pipedrive.
  """

  use TypedStruct

  typedstruct enforce: true do
    field :id, pos_integer()
    field :name, String.t()
    field :primary_email, String.t()
  end

  def new(map) do
    struct(__MODULE__, map)
  end
end

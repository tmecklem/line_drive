defmodule LineDrive.Organization do
  @moduledoc """
  This module and enclosed struct represent an organization in pipedrive.
  """

  use TypedStruct

  typedstruct do
    field :id, pos_integer()
    field :name, String.t(), enforce: true
  end

  def new(map) do
    struct(__MODULE__, map)
  end
end

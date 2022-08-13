defmodule LineDrive.User do
  @moduledoc """
  This module represents a user in pipedrive.
  """

  use TypedStruct

  typedstruct do
    field :id, pos_integer()
    field :name, String.t()
    field :email, String.t(), enforce: true
    field :active_flag, boolean(), default: true
  end

  def new(map) do
    struct(__MODULE__, map)
  end
end

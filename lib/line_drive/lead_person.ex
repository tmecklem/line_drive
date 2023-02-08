defmodule LineDrive.LeadPerson do
  @moduledoc """
  This module represent a lead person in pipedrive.
  """
  use TypedStruct

  typedstruct do
    field :id, pos_integer()
    field :name, String.t()
  end
end

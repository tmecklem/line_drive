defmodule LineDrive.PersonFieldOption do
  @moduledoc """
  This module represent a lead value in pipedrive.
  """
  use TypedStruct
  use LineDrive.Structable

  typedstruct do
    field :id, non_neg_integer()
    field :label, String.t()
  end
end

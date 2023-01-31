defmodule LineDrive.LeadValue do
  @moduledoc """
  This module represent a lead value in pipedrive.
  """
  use TypedStruct

  typedstruct do
    field :amount, float()
    field :currency, String.t()
  end
end

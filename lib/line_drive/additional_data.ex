defmodule LineDrive.AdditionalData do
  @moduledoc """
  This module and enclosed structs represent additional metadata in response data from pipedrive.
  """

  use TypedStruct

  alias LineDrive.Pagination

  typedstruct do
    field :pagination, Pagination.t()
  end

  def new(%{pagination: pagination}) do
    %__MODULE__{pagination: Pagination.new(pagination)}
  end
end

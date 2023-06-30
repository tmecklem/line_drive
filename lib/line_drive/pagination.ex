defmodule LineDrive.Pagination do
  @moduledoc """
  This module and enclosed structs represent pagination metadatafrom pipedrive.
  """

  use TypedStruct

  typedstruct do
    field :start, non_neg_integer()
    field :limit, non_neg_integer()
    field :more_items_in_collection, boolean()
  end

  def new(map) do
    struct(
      __MODULE__,
      map
    )
  end
end

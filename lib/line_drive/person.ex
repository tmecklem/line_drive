defmodule LineDrive.Person do
  @moduledoc """
  This module and enclosed struct represent a person in pipedrive.
  """

  @type t :: %__MODULE__{
          id: integer,
          name: binary(),
          primary_email: binary() | nil
        }

  @keys [
    :id,
    :name,
    :primary_email
  ]
  @enforce_keys @keys
  defstruct @keys

  def new(map) do
    struct(__MODULE__, map)
  end
end

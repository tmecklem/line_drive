defmodule LineDrive.ActivityParticipant do
  @moduledoc """
  This module and enclosed struct represent a activity participant in pipedrive.
  """

  @type t :: %__MODULE__{
          person_id: integer,
          primary_flag: boolean
        }

  @keys [
    :person_id,
    :primary_flag
  ]
  @enforce_keys @keys
  defstruct @keys

  def new(map) do
    struct(__MODULE__, map)
  end
end

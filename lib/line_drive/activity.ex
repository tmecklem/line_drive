defmodule LineDrive.Activity do
  @moduledoc """
  This module and enclosed struct represent a activity in pipedrive.
  """

  alias LineDrive.{
    ActivityParticipant,
    ActivityType
  }

  @type t :: %__MODULE__{
          busy_flag: boolean,
          deal_id: integer,
          done: integer,
          due_date: Date.t(),
          due_time: binary(),
          duration: binary(),
          id: binary(),
          lead_id: integer,
          location: binary(),
          note: binary(),
          org_id: integer,
          participants: list(ActivityParticipant.t()),
          person_id: integer,
          public_description: binary(),
          subject: binary(),
          type: ActivityType.key_string(),
          user_id: integer
        }

  @enforce_keys [:subject, :type]
  defstruct [
    :deal_id,
    :due_date,
    :due_time,
    :duration,
    :id,
    :lead_id,
    :location,
    :note,
    :org_id,
    :participants,
    :person_id,
    :public_description,
    :subject,
    :type,
    :user_id,
    busy_flag: false,
    done: 0
  ]

  defimpl Jason.Encoder, for: __MODULE__ do
    def encode(%{id: nil} = activity, opts) do
      Jason.Encode.value(Map.delete(Map.from_struct(activity), :id), opts)
    end

    def encode(activity, opts), do: Jason.encode(activity, opts)
  end

  def new(map) do
    struct(
      __MODULE__,
      map
      |> Map.put(:due_date, maybe_parse_due_date(map))
    )
  end

  defp maybe_parse_due_date(%{due_date: nil}), do: nil

  defp maybe_parse_due_date(%{due_date: %Date{} = date}), do: date

  defp maybe_parse_due_date(%{due_date: date_str}) do
    case Date.from_iso8601(date_str) do
      {:ok, date} -> date
      _ -> nil
    end
  end

  defp maybe_parse_due_date(_), do: nil
end

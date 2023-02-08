defmodule LineDrive.Activity do
  @moduledoc """
  This module and enclosed struct represent a activity in pipedrive.
  """

  alias LineDrive.{
    ActivityParticipant,
    ActivityType
  }

  use TypedStruct

  typedstruct do
    field :busy_flag, boolean()
    field :deal_id, pos_integer()
    field :done, 0 | 1
    field :due_date, Date.t()
    field :due_time, String.t()
    field :duration, String.t()
    field :id, pos_integer()
    field :lead_id, pos_integer()
    field :location, String.t()
    field :note, String.t()
    field :org_id, pos_integer()
    field :org_name, String.t()
    field :participants, list(ActivityParticipant.t())
    field :person_id, pos_integer()
    field :public_description, String.t()
    field :subject, String.t(), enforce: true
    field :type, ActivityType.key_string(), enforce: true
    field :user_id, pos_integer()
  end

  defimpl Jason.Encoder, for: __MODULE__ do
    def encode(%{id: nil} = activity, opts) do
      activity
      |> Map.from_struct()
      |> Map.delete(:id)
      |> Map.delete(:org_name)
      |> Jason.Encode.value(opts)
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

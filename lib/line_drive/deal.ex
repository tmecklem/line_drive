defmodule LineDrive.Deal do
  @moduledoc """
  This module and enclosed struct represent a deal in pipedrive.
  """

  use TypedStruct

  typedstruct do
    field :expected_close_date, Date.t()
    field :id, non_neg_integer()
    field :pipeline_id, non_neg_integer()
    field :stage_id, non_neg_integer()
    field :status, String.t()
    field :title, String.t()
    field :value, float()
    field :weighted_value, float()
    field :currency, String.t()
    field :add_time, DateTime.t()
    field :update_time, DateTime.t()
    field :stage_change_time, DateTime.t()
    field :active, boolean()
    field :deleted, boolean()
    field :probability, non_neg_integer()
    field :next_activity_date, Date.t()
    field :next_activity_time, Time.t()
    field :next_activity_id, non_neg_integer()
    field :last_activity_id, non_neg_integer()
    field :last_activity_date, Date.t()
    field :lost_reason, String.t()
    field :visible_to, non_neg_integer()
    field :close_time, DateTime.t()
    field :won_time, DateTime.t()
    field :first_won_time, DateTime.t()
    field :lost_time, DateTime.t()
    field :products_count, non_neg_integer()
    field :files_count, non_neg_integer()
    field :notes_count, non_neg_integer()
    field :followers_count, non_neg_integer()
    field :email_messages_count, non_neg_integer()
    field :activities_count, non_neg_integer()
    field :done_activities_count, non_neg_integer()
    field :undone_activities_count, non_neg_integer()
    field :participants_count, non_neg_integer()
    field :last_incoming_mail_time, DateTime.t()
    field :last_outgoing_mail_time, DateTime.t()
    field :label, String.t()
    field :stage_order_nr, non_neg_integer()
    field :person_name, String.t()
    field :org_name, String.t()
    field :next_activity_subject, String.t()
    field :next_activity_type, String.t()
    field :next_activity_duration, String.t()
    field :next_activity_note, String.t()
    field :formatted_value, String.t()
    field :formatted_weighted_value, String.t()
    field :weighted_value_currency, String.t()
    field :rotten_time, String.t()
    field :owner_name, String.t()
    field :cc_email, String.t()
    field :org_hidden, boolean()
    field :person_hidden, boolean()
    field :creator_user_id, LineDrive.User.t()
    field :user_id, LineDrive.User.t()
    field :org_id, non_neg_integer()
  end

  def new(map) do
    map
    |> atomize_keys()
    |> Map.update(:expected_close_date, nil, &parse_date/1)
    |> Map.update(:add_time, nil, &parse_datetime/1)
    |> Map.update(:stage_change_time, nil, &parse_datetime/1)
    |> Map.update(:next_activity_date, nil, &parse_date/1)
    |> Map.update(:next_activity_time, nil, &parse_time/1)
    |> Map.update(:last_activity_date, nil, &parse_date/1)
    |> Map.update(:close_time, nil, &parse_datetime/1)
    |> Map.update(:won_time, nil, &parse_datetime/1)
    |> Map.update(:first_won_time, nil, &parse_datetime/1)
    |> Map.update(:lost_time, nil, &parse_datetime/1)
    |> Map.update(:last_incoming_mail_time, nil, &parse_datetime/1)
    |> Map.update(:last_outgoing_mail_time, nil, &parse_datetime/1)
    |> Map.update(:creator_user_id, nil, &LineDrive.User.new/1)
    |> extract_org_id()
    |> then(&struct(__MODULE__, &1))
  end

  defp atomize_keys(map) do
    struct_keys()
    |> Enum.reduce(%{}, fn key, acc ->
      Map.put(acc, key, Map.get_lazy(map, key, fn -> Map.get(map, Atom.to_string(key), nil) end))
    end)
  end

  defp parse_date(nil), do: nil

  defp parse_date(date_str) do
    case Date.from_iso8601(date_str) do
      {:ok, date} -> date
      _ -> nil
    end
  end

  defp parse_datetime(nil), do: nil

  defp parse_datetime(date_str) do
    case NaiveDateTime.from_iso8601(date_str) do
      {:ok, date} -> date
      _ -> nil
    end
  end

  defp parse_time(val) when is_binary(val) do
    [hour, minute, second] =
      val
      |> String.split(":")
      |> Enum.map(&String.to_integer/1)

    case Time.new(hour, minute, second) do
      {:ok, date} -> date
      _ -> nil
    end
  end

  defp parse_time(_), do: nil

  defp struct_keys do
    Map.keys(__MODULE__.__struct__())
    |> List.delete(:__struct__)
  end

  defp extract_org_id(%{org_id: %{value: value}} = map), do: Map.put(map, :org_id, value)
  defp extract_org_id(map), do: map
end

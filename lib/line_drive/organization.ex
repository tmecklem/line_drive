defmodule LineDrive.Organization do
  @moduledoc """
  This module and enclosed struct represent an organization in pipedrive.
  """

  use TypedStruct

  typedstruct do
    field :owner_id, pos_integer()

    field :name, String.t(), enforce: true
    field :id, pos_integer()
    field :company_id, pos_integer()
    field :open_deals_count, non_neg_integer()
    field :related_open_deals_count, non_neg_integer()
    field :closed_deals_count, non_neg_integer()
    field :related_closed_deals_count, non_neg_integer()
    field :email_messages_count, non_neg_integer()
    field :people_count, non_neg_integer()
    field :activities_count, non_neg_integer()
    field :done_activities_count, non_neg_integer()
    field :undone_activities_count, non_neg_integer()
    field :files_count, non_neg_integer()
    field :notes_count, non_neg_integer()
    field :followers_count, non_neg_integer()
    field :won_deals_count, non_neg_integer()
    field :related_won_deals_count, non_neg_integer()
    field :lost_deals_count, non_neg_integer()
    field :related_lost_deals_count, non_neg_integer()
    field :active_flag, boolean()
    field :category_id, pos_integer()
    field :picture_id, pos_integer()
    field :country_code, String.t()
    field :first_char, String.t()
    field :update_time, NaiveDateTime.t()
    field :delete_time, NaiveDateTime.t()
    field :add_time, NaiveDateTime.t()
    field :visible_to, String.t()
    field :next_activity_date, Date.t()
    field :next_activity_time, Time.t()
    field :next_activity_id, non_neg_integer()
    field :last_activity_id, non_neg_integer()
    field :last_activity_date, Date.t()
    field :label, String.t()
    field :address, String.t()
    field :address_subpremise, String.t()
    field :address_street_number, String.t()
    field :address_route, String.t()
    field :address_sublocality, String.t()
    field :address_locality, String.t()
    field :address_admin_area_level_1, String.t()
    field :address_admin_area_level_2, String.t()
    field :address_country, String.t()
    field :address_postal_code, String.t()
    field :address_formatted_address, String.t()
    field :owner_name, String.t()
    field :cc_email, String.t()
  end

  defimpl Jason.Encoder, for: __MODULE__ do
    def encode(%{id: nil} = org, opts) do
      Jason.Encode.value(Map.take(Map.from_struct(org), [:name, :owner_id]), opts)
    end

    def encode(org, opts), do: Jason.encode(org, opts)
  end

  def new(map) do
    map
    |> atomize_keys()
    |> Map.update(:next_activity_date, nil, &parse_date/1)
    |> Map.update(:next_activity_time, nil, &parse_time/1)
    |> Map.update(:last_activity_date, nil, &parse_date/1)
    |> Map.update(:add_time, nil, &parse_datetime/1)
    |> Map.update(:update_time, nil, &parse_datetime/1)
    |> Map.update(:delete_time, nil, &parse_datetime/1)
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
end

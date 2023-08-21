defmodule LineDrive.PersonField do
  @moduledoc """
  This module and enclosed struct represent a person field in pipedrive.
  """

  use TypedStruct

  typedstruct do
    field :id, pos_integer()
    field :key, String.t()
    field :name, String.t()
    field :order_nr, non_neg_integer()
    field :field_type, String.t()
    field :json_column_flag, boolean()
    field :add_time, NaiveDateTime.t()
    field :update_time, NaiveDateTime.t()
    field :last_updated_by_user_id, pos_integer()
    field :edit_flag, boolean()
    field :details_visible_flag, boolean()
    field :add_visible_flag, boolean()
    field :important_flag, boolean()
    field :bulk_edit_allowed, boolean()
    field :filtering_allowed, boolean()
    field :sortable_flag, boolean()
    field :searchable_flag, boolean()
    field :active_flag, boolean()
    field :mandatory_flag, boolean()
  end

  def new(map) do
    map
    |> atomize_keys()
    |> Map.update(:add_time, nil, &parse_datetime/1)
    |> Map.update(:update_time, nil, &parse_datetime/1)
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

  defp struct_keys do
    Map.keys(__MODULE__.__struct__())
    |> List.delete(:__struct__)
  end
end

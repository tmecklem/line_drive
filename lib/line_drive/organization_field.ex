defmodule LineDrive.OrganizationField do
  @moduledoc """
  This module and enclosed structs represent an organization field in pipedrive.
  """

  use TypedStruct

  typedstruct do
    field :id, pos_integer()
    field :key, String.t()
    field :name, String.t()
    field :order_nr, pos_integer()
    field :field_type, String.t()
    field :json_column_flag, boolean()
    field :add_time, Date.t()
    field :update_time, Date.t()
    field :last_updated_by_user_id, pos_integer()
    field :edit_flag, boolean()
    field :details_visible_flag, boolean()
    field :add_visible_flag, boolean()
    field :important_flag, boolean()
    field :bulk_edit_allowed, boolean()
    field :filtering_allowed, boolean()
    field :sortable_flag, boolean()
    field :mandatory_flag, boolean()
    field :link, String.t()
    field :use_field, String.t()
    field :active_flag, boolean()
    field :index_visible_flag, boolean()
    field :searchable_flag, boolean()
  end

  defimpl Jason.Encoder, for: __MODULE__ do
    def encode(%{} = organization_field, opts) do
      Jason.Encode.value(
        Map.take(Map.from_struct(organization_field), [
          :key,
          :name
        ]),
        opts
      )
    end

    def encode(organization_field, opts), do: Jason.encode(organization_field, opts)
  end

  def new(map) do
    map
    |> atomize_keys()
    |> then(&struct(__MODULE__, &1))
  end

  defp atomize_keys(map) do
    struct_keys()
    |> Enum.reduce(%{}, fn key, acc ->
      Map.put(acc, key, Map.get_lazy(map, key, fn -> Map.get(map, Atom.to_string(key), nil) end))
    end)
  end

  defp struct_keys do
    Map.keys(__MODULE__.__struct__())
    |> List.delete(:__struct__)
  end
end

defmodule LineDrive.Lead do
  @moduledoc """
  This module and enclosed struct represent a lead in pipedrive.
  """

  use TypedStruct

  typedstruct do
    field :expected_close_date, Date.t()
    field :id, String.t()
    field :title, String.t(), enforce: true
    field :person_id, pos_integer()
    field :value, float()
  end

  defimpl Jason.Encoder, for: __MODULE__ do
    def encode(%{id: nil} = lead, opts) do
      Jason.Encode.value(
        Map.take(Map.from_struct(lead), [:title, :id, :person_id, :amount, :expected_close_date]),
        opts
      )
    end

    def encode(lead, opts), do: Jason.encode(lead, opts)
  end

  def new(map) do
    struct(
      __MODULE__,
      map
      |> Map.put(:expected_close_date, maybe_parse_expected_close_date(map))
    )
  end

  defp maybe_parse_expected_close_date(%{expected_close_date: nil}), do: nil

  defp maybe_parse_expected_close_date(%{expected_close_date: %Date{} = date}), do: date

  defp maybe_parse_expected_close_date(%{expected_close_date: date_str}) do
    case Date.from_iso8601(date_str) do
      {:ok, date} -> date
      _ -> nil
    end
  end

  defp maybe_parse_expected_close_date(_), do: nil
end

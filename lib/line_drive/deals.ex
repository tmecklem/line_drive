defmodule LineDrive.Deals do
  @moduledoc """
  This module encapsulates calls to the pipedrive deals resource API
  """

  use Tesla

  alias LineDrive.Deal
  alias Tesla.Client

  @callback get_deal(Client.t(), integer) :: {:ok, Deal.t()}

  def get_deal(%Client{} = client, deal_id) do
    client
    |> get("/api/v1/deals", query: [id: deal_id])
    |> case do
      {:ok, %Tesla.Env{status: 200, body: %{data: deal_data}}} ->
        {:ok, Deal.new(deal_data)}

      {:error, env} ->
        {:error, env}
    end
  end
end

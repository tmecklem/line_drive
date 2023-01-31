defmodule LineDrive.Deals do
  @moduledoc """
  This module encapsulates calls to the pipedrive deals resource API
  """

  use Tesla

  alias LineDrive.Deal
  alias Tesla.Client

  @callback get_deal(Client.t(), integer) :: {:ok, Deal.t()}
  @callback search_deals(Client.t(), binary()) :: {:ok, list(Deal.t())}

  def get_deal(%Client{} = client, deal_id) do
    client
    |> get("/api/v1/deals/:id", opts: [path_params: [id: deal_id]])
    |> case do
      {:ok, %Tesla.Env{status: 200, body: %{data: deal_data}}} ->
        {:ok, Deal.new(deal_data)}

      {:ok, %Tesla.Env{body: %{success: false, error: message}}} ->
        {:error, message}

      {:error, env} ->
        {:error, env}
    end
  end

  def search_deals(%Client{} = client, term, opts \\ []) do
    start = Keyword.get(opts, :start, 0)
    limit = Keyword.get(opts, :limit, 50)
    status = Keyword.get(opts, :status, "open")

    client
    |> get("/api/v1/deals/search", query: [term: term, start: start, limit: limit, status: status])
    |> case do
      {:ok, %Tesla.Env{status: 200, body: %{success: true, data: data}}} ->
        deals =
          data
          |> Map.get(:items)
          |> Enum.map(fn item_container -> Deal.new(item_container.item) end)

        {:ok, deals}

      {:ok, %Tesla.Env{body: %{success: false, error: message}}} = item ->
        {:error, message}

      {:error, env} ->
        {:error, env}
    end
  end
end

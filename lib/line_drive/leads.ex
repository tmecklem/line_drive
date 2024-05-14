defmodule LineDrive.Leads do
  @moduledoc """
  This module encapsulates calls to the pipedrive leads resource API
  """

  use Tesla

  alias LineDrive.Lead
  alias Tesla.Client

  @callback create_lead(Client.t(), Lead.t()) :: {:ok, Lead.t()}
  @callback get_lead(Client.t(), String.t()) :: {:ok, Lead.t()}
  @callback search_leads(Client.t(), binary()) :: {:ok, list(Lead.t())}

  def create_lead(%Client{} = client, %Lead{id: nil} = lead) do
    client
    |> post("/api/v1/leads", lead)
    |> case do
      {:ok, %Tesla.Env{status: 201, body: %{"data" => lead_data}}} ->
        {:ok, Lead.new(lead_data)}

      {:ok, %Tesla.Env{body: %{"success" => false, "error" => message}}} ->
        {:error, message}

      {:error, env} ->
        {:error, env}
    end
  end

  def get_lead(%Client{} = client, lead_id) do
    client
    |> get("/api/v1/leads/:id", opts: [path_params: [id: lead_id]])
    |> case do
      {:ok, %Tesla.Env{status: 200, body: %{"data" => lead_data}}} ->
        {:ok, Lead.new(lead_data)}

      {:ok, %Tesla.Env{body: %{"success" => false, "error" => message}}} ->
        {:error, message}

      {:error, env} ->
        {:error, env}
    end
  end

  def search_leads(%Client{} = client, term, opts \\ []) do
    start = Keyword.get(opts, :start, 0)
    limit = Keyword.get(opts, :limit, 50)

    all_opts = opts |> Keyword.merge(term: term, start: start, limit: limit)

    client
    |> get("/api/v1/leads/search", query: all_opts)
    |> case do
      {:ok, %Tesla.Env{status: 200, body: %{"success" => true, "data" => data}}} ->
        leads =
          data
          |> Map.get("items")
          |> Enum.map(fn item_container -> Lead.new(Map.get(item_container, "item")) end)

        {:ok, leads}

      {:ok, %Tesla.Env{body: %{"success" => false, "error" => message}}} ->
        {:error, message}

      {:error, env} ->
        {:error, env}
    end
  end
end

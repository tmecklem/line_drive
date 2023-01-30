defmodule LineDrive.Organizations do
  @moduledoc """
  This module encapsulates calls to the pipedrive organizations resource API
  """

  use Tesla

  alias LineDrive.Organization
  alias Tesla.Client

  @callback get_organization(Client.t(), integer) :: {:ok, Organization.t()}
  @callback create_organization(Client.t(), binary()) :: {:ok, Organization.t()}
  @callback search_organizations(Client.t(), binary()) :: {:ok, list(Organization.t())}

  def get_organization(%Client{} = client, org_id) do
    client
    |> get("/api/v1/organizations/:id", opts: [path_params: [id: org_id]])
    |> case do
      {:ok, %Tesla.Env{status: 200, body: %{data: org_data}}} ->
        {:ok, Organization.new(org_data)}

      {:error, env} ->
        {:error, env}
    end
  end

  def create_organization(%Client{} = client, %Organization{id: nil} = org) do
    client
    |> post("/api/v1/organizations", org)
    |> case do
      {:ok, %Tesla.Env{status: 201, body: %{data: org_data}}} ->
        {:ok, Organization.new(org_data)}

      {:error, env} ->
        {:error, env}
    end
  end

  def search_organizations(%Client{} = client, term, opts \\ []) do
    start = Keyword.get(opts, :start, 0)
    limit = Keyword.get(opts, :limit, 50)

    client
    |> get("/api/v1/organizations/search", query: [term: term, start: start, limit: limit])
    |> case do
      {:ok, %Tesla.Env{status: 200, body: %{success: true, data: data}}} ->
        organizations =
          data
          |> Map.get(:items)
          |> Enum.map(fn item_container -> Organization.new(item_container.item) end)

        {:ok, organizations}

      {:error, env} ->
        {:error, env}
    end
  end
end

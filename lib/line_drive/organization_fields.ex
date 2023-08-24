defmodule LineDrive.OrganizationFields do
  @moduledoc """
  This module encapsulates calls to the pipedrive organization fields resource API
  """

  use Tesla

  alias LineDrive.Field
  alias LineDrive.OrganizationField
  alias LineDrive.PagedResult
  alias Tesla.Client

  @callback get_org_field_keys_and_names(Client.t(), binary()) :: {:ok, OrganizationField.t()}
  @callback list_organization_fields(Client.t(), [any()]) :: {:ok, PagedResult.t()}

  def list_organization_fields(%Client{} = client, opts \\ []) do
    start = Keyword.get(opts, :start, 0)
    limit = Keyword.get(opts, :limit, 50)

    client
    |> get("/api/v1/organizationFields", query: [start: start, limit: limit])
    |> case do
      {:ok, %Tesla.Env{status: 200, body: %{"success" => true, "data" => nil} = body}} ->
        {:ok, PagedResult.new([], body)}

      {:ok, %Tesla.Env{status: 200, body: %{"success" => true, "data" => data} = body}} ->
        organization_fields =
          data
          |> Enum.map(fn organization_field -> Field.new(organization_field) end)

        {:ok, PagedResult.new(organization_fields, body)}

      {:ok, %Tesla.Env{body: %{"success" => false, "error" => message}}} ->
        {:error, message}

      {:error, env} ->
        {:error, env}
    end
  end

  def get_org_field_keys_and_names(%Client{} = client, opts \\ []) do
    start = Keyword.get(opts, :start, 0)
    limit = Keyword.get(opts, :limit, 200)

    client
    |> get("/api/v1/organizationFields/", query: [start: start, limit: limit])
    |> case do
      {:ok, %Tesla.Env{status: 200, body: %{"success" => true, "data" => data}}} ->
        org_fields =
          data
          |> Enum.map(fn item ->
            item
            |> Map.take(["key", "name"])
            |> OrganizationField.new()
          end)

        {:ok, org_fields}

      {:ok, %Tesla.Env{body: %{"success" => false, "error" => message}}} ->
        {:error, message}

      {:error, env} ->
        {:error, env}
    end
  end
end

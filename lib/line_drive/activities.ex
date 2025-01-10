defmodule LineDrive.Activities do
  @moduledoc """
  This module encapsulates calls to the pipedrive activities resource API
  """
  use Tesla

  alias LineDrive.Activity
  alias LineDrive.PagedResult

  alias Tesla.Client

  @callback add_activity(Client.t(), Activity.t()) :: {:ok, Activity.t()}
  @callback list_activities(Client.t(), keyword()) :: {:ok, PagedResult.t()}

  def add_activity(%Client{} = client, %Activity{id: nil} = activity) do
    client
    |> post("/api/v1/activities", activity)
    |> case do
      {:ok, %Tesla.Env{status: 201, body: %{"data" => activity_data}}} ->
        {:ok, Activity.new(activity_data)}

      {:ok, %Tesla.Env{body: %{"success" => false, "error" => message}}} ->
        {:error, message}

      {:error, env} ->
        {:error, env}
    end
  end

  def list_activities(%Client{} = client, opts \\ []) do
    params = [
      limit: Keyword.get(opts, :limit, 100)
    ]

    params =
      if cursor = Keyword.get(opts, :cursor) do
        [{:cursor, cursor} | params]
      else
        params
      end

    params =
      if since = Keyword.get(opts, :since) do
        [{:since, since} | params]
      else
        params
      end

    params =
      if until = Keyword.get(opts, :until) do
        [{:until, until} | params]
      else
        params
      end

    client
    |> get("/api/v1/activities/collection", query: params)
    |> case do
      {:ok, %Tesla.Env{status: 200, body: %{"success" => true} = body}} ->
        {:ok,
         %PagedResult{
           success: true,
           data: Enum.map(body["data"], &Activity.new/1),
           additional_data: LineDrive.AdditionalData.new(body["additional_data"])
         }}

      {:ok, %Tesla.Env{body: %{"success" => false, "error" => message}}} ->
        {:error, message}

      {:error, env} ->
        {:error, env}
    end
  end
end

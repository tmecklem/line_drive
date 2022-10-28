defmodule LineDrive.Activities do
  @moduledoc """
  This module encapsulates calls to the pipedrive activities resource API
  """
  use Tesla

  alias LineDrive.Activity

  alias Tesla.Client

  @callback add_activity(Client.t(), Activity.t()) :: {:ok, Activity.t()}
  @callback list_activities(Client.t(), keyword()) :: {:ok, list(Activity.t())}

  def add_activity(%Client{} = client, %Activity{id: nil} = activity) do
    client
    |> post("/api/v1/activities", activity)
    |> case do
      {:ok, %Tesla.Env{status: 201, body: %{data: activity_data}}} ->
        {:ok, Activity.new(activity_data)}

      {:error, env} ->
        {:error, env}
    end
  end

  def list_activities(%Client{} = client, _opts \\ []) do
    client
    |> get("/api/v1/activities")
    |> case do
      {:ok, %Tesla.Env{status: 200, body: %{data: activities}}} ->
        {:ok, Enum.map(activities, &Activity.new/1)}

      {:error, env} ->
        {:error, env}
    end
  end
end

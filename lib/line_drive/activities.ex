defmodule LineDrive.Activities do
  @moduledoc """
  This module encapsulates calls to the pipedrive activities resource API
  """
  use Tesla

  alias LineDrive.Activity

  alias Tesla.Client

  @callback add_activity(Client.t(), Activity.t()) :: {:ok, Activity.t()}

  def add_activity(%Client{} = client, %Activity{} = activity) do
    client
    |> post("/api/v1/activities", activity)
    |> case do
      {:ok, %Tesla.Env{status: 200, body: %{data: activity_data}}} ->
        {:ok, Activity.new(activity_data)}

      {:error, env} ->
        {:error, env}
    end
  end
end

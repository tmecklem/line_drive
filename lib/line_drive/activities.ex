defmodule LineDrive.Activities do
  @moduledoc """
  This module encapsulates calls to the pipedrive activities resource API
  """
  use Tesla

  alias LineDrive.{
    Activity,
    Person,
    User
  }

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
      {:ok, %Tesla.Env{status: 200, body: %{data: activities, related_objects: related_objects}}} ->
        {:ok,
         activities
         |> Enum.map(fn activity_map ->
           activity_map
           |> Activity.new()
           |> populate_related_objects(related_objects)
         end)}

      {:error, env} ->
        {:error, env}
    end
  end

  defp populate_related_objects(%Activity{} = activity, related_objects) do
    activity
    |> maybe_populate_user(related_objects)
    |> maybe_populate_person(related_objects)
  end

  defp maybe_populate_person(%Activity{person_id: nil} = activity, _), do: activity

  defp maybe_populate_person(%Activity{person_id: person_id} = activity, %{person: persons_map}) do
    case Map.get(persons_map, String.to_atom(Integer.to_string(person_id))) do
      nil -> activity
      person_map -> %{activity | person: Person.new(person_map)}
    end
  end

  defp maybe_populate_user(%Activity{user_id: nil} = activity, _), do: activity

  defp maybe_populate_user(%Activity{user_id: user_id} = activity, %{user: users_map}) do
    case Map.get(users_map, String.to_atom(Integer.to_string(user_id))) do
      nil -> activity
      user_map -> %{activity | user: User.new(user_map)}
    end
  end
end

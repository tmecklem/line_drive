defmodule LineDrive.Persons do
  @moduledoc """
  This module encapsulates calls to the pipedrive person resource API
  """

  use Tesla

  alias LineDrive.Person
  alias Tesla.Client

  @callback get_person(Client.t(), integer) :: {:ok, Person.t()}
  @callback search_persons(Client.t(), binary()) :: {:ok, list(Person.t())}

  def get_person(%Client{} = client, id) do
    client
    |> get("/api/v1/persons/:id", opts: [path_params: [id: id]])
    |> case do
      {:ok, %Tesla.Env{status: 200, body: %{success: true, data: data}}} ->
        {:ok, Person.new(data)}

      {:error, env} ->
        {:error, env}
    end
  end

  def search_persons(%Client{} = client, term, opts \\ []) do
    start = Keyword.get(opts, :start, 0)
    limit = Keyword.get(opts, :limit, 50)

    client
    |> get("/api/v1/persons/search", query: [term: term, start: start, limit: limit])
    |> case do
      {:ok, %Tesla.Env{status: 200, body: %{success: true, data: data}}} ->
        persons =
          data
          |> Map.get(:items)
          |> Enum.map(fn item_container -> Person.new(item_container.item) end)

        {:ok, persons}

      {:error, env} ->
        {:error, env}
    end
  end
end

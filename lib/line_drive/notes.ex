defmodule LineDrive.Notes do
  @moduledoc """
  This module encapsulates calls to the pipedrive notes resource API
  """

  use Tesla

  alias Hex.API.Key
  alias LineDrive.Note
  alias Tesla.Client

  @callback add_note(Client.t(), Note.t()) :: {:ok, Note.t()}
  @callback get_all_org_notes(Client.t(), binary()) :: {:ok, list(Note.t())}

  def add_note(%Client{} = client, %Note{id: nil} = note) do
    client
    |> post("/api/v1/notes", note)
    |> case do
      {:ok, %Tesla.Env{status: 201, body: %{data: note_data}}} ->
        {:ok, Note.new(note_data)}

      {:ok, %Tesla.Env{body: %{success: false, error: message}}} ->
        {:error, message}

      {:error, env} ->
        {:error, env}
    end
  end

  def get_all_org_notes(%Client{} = client, org_id, opts \\ []) do
    sort = Keyword.get(opts, :sort, "add_time DESC")
    start = Keyword.get(opts, :start, 0)
    limit = Keyword.get(opts, :limit, 20)

    client
    |> get("/api/v1/notes", query: [org_id: org_id, start: start, limit: limit, sort: sort])
    |> case do
      {:ok, %Tesla.Env{status: 200, body: %{success: true, data: data}}} ->
        notes =
          data
          |> Enum.map(fn note_container ->
            Note.new(note_container)
          end)

        {:ok, notes}

      {:ok, %Tesla.Env{body: %{success: false, error: message}}} ->
        {:error, message}

      {:error, env} ->
        {:error, env}
    end
  end
end

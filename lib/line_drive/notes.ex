defmodule LineDrive.Notes do
  @moduledoc """
  This module encapsulates calls to the pipedrive notes resource API
  """

  use Tesla

  alias LineDrive.Note
  alias Tesla.Client

  @callback add_note(Client.t(), Note.t()) :: {:ok, Note.t()}

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
end

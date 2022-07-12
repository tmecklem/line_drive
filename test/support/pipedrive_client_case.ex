defmodule LineDrive.PipedriveClientCase do
  @moduledoc """
  Case for tests that require configuration of the client to point to a fake pipedrive API server for testing
  """

  use ExUnit.CaseTemplate
  alias LineDrive.FakePipedriveServer

  # using do
  #   quote do
  #   end
  # end

  setup do
    start_supervised(
      {Plug.Cowboy, scheme: :http, plug: FakePipedriveServer, options: [port: 4006]}
    )

    client = LineDrive.client("api_token", "http://localhost:4006/")
    {:ok, client: client}
  end
end

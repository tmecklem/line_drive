defmodule LineDrive do
  @moduledoc """
  This is the entrypoint for making requests to pipedrive via LineDrive.
  """

  use Tesla

  def client(api_token, base_url) do
    middleware = [
      {Tesla.Middleware.BaseUrl, base_url},
      {Tesla.Middleware.JSON, engine: Jason, engine_opts: [keys: :atoms]},
      {Tesla.Middleware.Query, api_token: api_token}
    ]

    Tesla.client(middleware)
  end
end

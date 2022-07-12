defmodule LineDrive do
  @moduledoc """
  This is the entrypoint for making requests to pipedrive via LineDrive.
  """

  use Tesla

  defdelegate get_deal(client, deal_id), to: LineDrive.Deals
  defdelegate list_pipelines(client), to: LineDrive.Pipelines
  defdelegate list_pipeline_deals(client, pipeline_id), to: LineDrive.Pipelines

  def client(api_token, base_url) do
    middleware = [
      {Tesla.Middleware.BaseUrl, base_url},
      {Tesla.Middleware.JSON, engine: Jason, engine_opts: [keys: :atoms]},
      {Tesla.Middleware.Query, api_token: api_token}
    ]

    Tesla.client(middleware)
  end
end

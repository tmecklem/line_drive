defmodule LineDrive do
  @moduledoc """
  This is the entrypoint for making requests to pipedrive via LineDrive.
  """

  use Tesla

  defdelegate add_activity(client, activity), to: LineDrive.Activities

  defdelegate list_activity_types(client), to: LineDrive.ActivityTypes

  defdelegate get_deal(client, deal_id), to: LineDrive.Deals
  defdelegate search_deals(client, term, opts), to: LineDrive.Deals

  defdelegate get_person(client, person_id), to: LineDrive.Persons
  defdelegate search_persons(client, term, opts), to: LineDrive.Persons

  defdelegate list_pipelines(client), to: LineDrive.Pipelines
  defdelegate list_pipeline_deals(client, pipeline_id), to: LineDrive.Pipelines

  defdelegate find_users_by_name(client, term, opts \\ []), to: LineDrive.Users

  def client(api_token, base_url) do
    middleware = [
      {Tesla.Middleware.BaseUrl, base_url},
      {Tesla.Middleware.JSON, engine: Jason, engine_opts: [keys: :atoms]},
      {Tesla.Middleware.Query, api_token: api_token},
      Tesla.Middleware.PathParams
    ]

    Tesla.client(middleware)
  end
end

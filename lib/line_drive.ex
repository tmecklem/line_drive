defmodule LineDrive do
  @moduledoc """
  This is the entrypoint for making requests to pipedrive via LineDrive.
  """

  use Tesla

  defdelegate add_activity(client, activity), to: LineDrive.Activities

  defdelegate list_activity_types(client), to: LineDrive.ActivityTypes

  defdelegate get_deal(client, deal_id), to: LineDrive.Deals
  defdelegate search_deals(client, term, opts), to: LineDrive.Deals

  defdelegate get_lead(client, lead_id), to: LineDrive.Leads
  defdelegate search_leads(client, term, opts), to: LineDrive.Leads
  defdelegate create_lead(client, lead), to: LineDrive.Leads

  defdelegate add_note(client, note), to: LineDrive.Notes
  defdelegate get_all_org_notes(client, org_id, opts), to: LineDrive.Notes

  defdelegate get_org_field_keys_and_names(client, opts), to: LineDrive.OrganizationFields

  defdelegate get_organization(client, org_id), to: LineDrive.Organizations
  defdelegate search_organizations(client, term, opts), to: LineDrive.Organizations
  defdelegate create_organization(client, org), to: LineDrive.Organizations

  defdelegate get_person(client, person_id), to: LineDrive.Persons
  defdelegate create_person(client, person), to: LineDrive.Persons
  defdelegate search_persons(client, term, opts), to: LineDrive.Persons

  defdelegate list_pipelines(client), to: LineDrive.Pipelines
  defdelegate list_pipeline_deals(client, pipeline_id), to: LineDrive.Pipelines

  defdelegate find_users_by_name(client, term, opts \\ []), to: LineDrive.Users

  def client(api_token, base_url) do
    base_url = process_base(base_url)

    middleware = [
      {Tesla.Middleware.BaseUrl, base_url},
      {Tesla.Middleware.JSON, engine: Jason, engine_opts: [keys: :atoms]},
      {Tesla.Middleware.Query, api_token: api_token},
      Tesla.Middleware.PathParams
    ]

    Tesla.client(middleware)
  end

  def build_client(refresh_token, client_id, client_secret, base_url) do
    base_url = process_base(base_url)

    case LineDrive.Oauth.refresh_access_token(refresh_token, client_id, client_secret) do
      {:ok, access_token} ->
        middleware = [
          {Tesla.Middleware.BaseUrl, base_url},
          {Tesla.Middleware.BearerAuth, token: access_token},
          {Tesla.Middleware.JSON, engine: Jason, engine_opts: [keys: :atoms]},
          Tesla.Middleware.PathParams
        ]

        {:ok, Tesla.client(middleware)}

      {:error, error} ->
        {:error, error}
    end
  end

  defp process_base(base_url) do
    if Regex.match?(~r/^https?:\/\//i, base_url) do
      base_url
    else
      "https://" <> base_url
    end
  end
end

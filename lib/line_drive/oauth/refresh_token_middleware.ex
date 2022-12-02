defmodule LineDrive.Oauth.RefreshTokenMiddleware do
  @behaviour Tesla.Middleware

  # @auth_header "Basic " <> Base.encode64(@client_id <> ":" <> @client_secret)
  #
  # use Tesla
  #
  # def get_auth_token() do
  #   client = Tesla.client([{Tesla.Middleware.Headers, [{"authorization", @auth_header}]}, Tesla.Middleware.FormUrlencoded])
  #   post(client, "https://oauth.pipedrive.com/oauth/token", %{
  #     grant_type: "authorization_code",
  #     code: @authorization_code,
  #     redirect_uri: "http://lvh.me:4000/auth/pipedrive/callback"
  #   })
  # end
  #
  # def refresh_auth_token(refresh_token) do
  #   client = Tesla.client([{Tesla.Middleware.Headers, [{"authorization", @auth_header}]}, Tesla.Middleware.FormUrlencoded])
  #   post(client, "https://oauth.pipedrive.com/oauth/token", %{
  #     grant_type: "refresh_token",
  #     code: refresh_token
  #   })
  # end
  #
  # def deals(access_token) do
  #   client = Tesla.client([{Tesla.Middleware.BearerAuth, token: access_token}])
  #   get(client, "https://launchscout-sandbox-tim.pipedrive.com/api/v1/deals")
  # end

  @impl Tesla.Middleware
  def call(env, next, options) do
    resp = Tesla.run(env, next)

    if {:error, %{status: 401}} = resp do
      
    else
      resp
    end
  end
end

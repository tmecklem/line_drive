# LineDrive

LineDrive is a client package for communicating with Pipedrive (pipedrive.com).

Goals:
* Basic API support for Pipedrive Resources (Deals, etc)
* WebHook support for pipedrive event callback
* OAuth support for Marketplace support (and to perform actions on behalf of users)

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `line_drive` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:line_drive, "~> 0.1.0"}
  ]
end
```

The docs can be found at <https://hexdocs.pm/line_drive>.

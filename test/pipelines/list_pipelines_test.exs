defmodule LineDrive.Pipelines.ListPipelinesTest do
  @moduledoc false
  use LineDrive.PipedriveClientCase, async: false

  alias LineDrive.{
    Pipeline,
    Pipelines
  }

  describe "list_pipelines" do
    test "it forms a correct request and returns a list of pipelines", %{client: client} do
      assert {:ok, [%Pipeline{name: "Pipeline"}]} = Pipelines.list_pipelines(client)
    end
  end
end

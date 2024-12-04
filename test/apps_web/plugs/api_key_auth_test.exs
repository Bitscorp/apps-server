defmodule AppsWeb.Plugs.ApiKeyAuthTest do
  use AppsWeb.ConnCase

  alias AppsWeb.Plugs.ApiKeyAuth

  import Apps.ProjectsFixtures

  describe "api key authentication" do
    setup do
      project = project_fixture()
      %{project: project}
    end

    test "authenticates when valid API key is provided", %{conn: conn, project: project} do
      conn =
        conn
        |> put_req_header("x-api-key", project.api_key)
        |> Map.put(:params, %{"project_id" => to_string(project.id)})
        |> ApiKeyAuth.call([])

      refute conn.halted
      assert conn.assigns.current_project.id == project.id
    end

    test "returns error when API key is missing", %{conn: conn} do
      conn =
        conn
        |> ApiKeyAuth.call([])

      assert conn.halted
      assert conn.status == 401
      assert json_response(conn, 401) == %{"error" => "ERROR_MISSING_API_KEY"}
    end

    test "returns error when API key is invalid", %{conn: conn} do
      conn =
        conn
        |> put_req_header("x-api-key", "invalid_api_key")
        |> ApiKeyAuth.call([])

      assert conn.halted
      assert conn.status == 401
      assert json_response(conn, 401) == %{"error" => "ERROR_INVALID_API_KEY"}
    end

    test "returns error when project ID doesn't match API key", %{conn: conn, project: project} do
      conn =
        conn
        |> put_req_header("x-api-key", project.api_key)
        |> Map.put(:params, %{"project_id" => "different_id"})
        |> ApiKeyAuth.call([])

      assert conn.halted
      assert conn.status == 401
      assert json_response(conn, 401) == %{"error" => "ERROR_PROJECT_MISMATCH"}
    end

    test "succeeds when no project_id in path params", %{conn: conn, project: project} do
      conn =
        conn
        |> put_req_header("x-api-key", project.api_key)
        |> Map.put(:params, %{})
        |> ApiKeyAuth.call([])

      refute conn.halted
      assert conn.assigns.current_project.id == project.id
    end
  end
end

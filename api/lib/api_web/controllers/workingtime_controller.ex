defmodule ApiWeb.WorkingtimeController do
  use ApiWeb, :controller
  require Logger
  alias Api.Accounts
  alias Api.Accounts.Workingtime

  action_fallback ApiWeb.FallbackController

  def index(conn, _params) do
    workingtimes = Accounts.list_workingtimes()
    render(conn, "index.json", workingtimes: workingtimes)
  end

  # def create(conn, %{"workingtime" => workingtime_params}) do
  #   with {:ok, %Workingtime{} = workingtime} <- Accounts.create_workingtime(workingtime_params) do
  #     conn
  #     |> put_status(:created)
  #     |> put_resp_header("location", Routes.workingtime_path(conn, :show, workingtime))
  #     |> render("show.json", workingtime: workingtime)
  #   end
  # end

  def create(conn, %{"start" => start, "end" => stop, "userID" => user_id}) do
    user = String.to_integer(user_id)
    with {:ok, %Workingtime{} = workingtime} <- Accounts.create_workingtime(%{start: start, end: stop, user_id: user}) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.workingtime_path(conn, :show, workingtime))
      |> render("show.json", workingtime: workingtime)
    end
  end

  def show(conn, %{"id" => id}) do
    workingtime = Accounts.get_workingtime!(id)
    render(conn, "show.json", workingtime: workingtime)
  end

  def showByUser(conn, %{"userID" => id, "start" => start, "end" => stop}) do
    workingtimes = Accounts.get_workingtimes_by_params(id, start, stop)
    render(conn, "index.json", workingtimes: workingtimes)
  end

  def update(conn, %{"id" => id, "start" => start, "end" => stop}) do
    workingtime = Accounts.get_workingtime!(id)

    with {:ok, %Workingtime{} = workingtime} <- Accounts.update_workingtime(workingtime, %{start: start, end: stop}) do
      render(conn, "show.json", workingtime: workingtime)
    end
  end

  def delete(conn, %{"id" => id}) do
    workingtime = Accounts.get_workingtime!(id)

    with {:ok, %Workingtime{}} <- Accounts.delete_workingtime(workingtime) do
      send_resp(conn, :no_content, "")
    end
  end
end

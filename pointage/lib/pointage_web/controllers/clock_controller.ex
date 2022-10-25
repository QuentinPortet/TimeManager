defmodule PointageWeb.ClockController do
  use PointageWeb, :controller

  alias Pointage.Accounts
  alias Pointage.Accounts.Clock

  action_fallback PointageWeb.FallbackController

  def index(conn, _params) do
    clocks = Accounts.list_clocks()
    render(conn, "index.json", clocks: clocks)
  end

  def create(conn, clock_params) do
    with {:ok, %Clock{} = clock} <- Accounts.create_clock(clock_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.clock_path(conn, :show, clock))
      |> render("show.json", clock: clock)
    end
  end

  def show(conn, %{"userID" => id}) do
    clock = Accounts.get_clock!(id)
    render(conn, "show.json", clock: clock)
  end

  def showByUser(conn, %{"userID" => userID}) do
    clock = Accounts.get_clocks_by_user(userID)
    render(conn, "show.json", clock: clock)
  end

  def update(conn, %{"id" => id, "clock" => clock_params}) do
    clock = Accounts.get_clock!(id)

    with {:ok, %Clock{} = clock} <- Accounts.update_clock(clock, clock_params) do
      render(conn, "show.json", clock: clock)
    end
  end

  def delete(conn, %{"id" => id}) do
    clock = Accounts.get_clock!(id)

    with {:ok, %Clock{}} <- Accounts.delete_clock(clock) do
      send_resp(conn, :no_content, "")
    end
  end
end

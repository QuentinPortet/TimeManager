defmodule TimemanagerWeb.UserController do
  use TimemanagerWeb, :controller

  alias Timemanager.TimeManager
  alias Timemanager.TimeManager.User

  action_fallback TimemanagerWeb.FallbackController

  def index(conn, _params) do
    users = TimeManager.list_users()
    render(conn, "index.json", users: users)
  end

  def create(conn, params) do
    with {:ok, %User{} = user} <- TimeManager.create_user(params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.user_path(conn, :show, user))
      |> render("show.json", user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    user = TimeManager.get_user!(id)
    render(conn, "show.json", user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = TimeManager.get_user!(id)

    with {:ok, %User{} = user} <- TimeManager.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = TimeManager.get_user!(id)

    with {:ok, %User{}} <- TimeManager.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end
end

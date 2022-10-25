defmodule PointageWeb.UserController do
  use PointageWeb, :controller

  alias Pointage.Accounts
  alias Pointage.Accounts.User

  action_fallback PointageWeb.FallbackController

  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, "index.json", users: users)
  end

  def create(conn, params) do
    with {:ok, %User{} = user} <- Accounts.create_user(params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.user_path(conn, :show, user))
      |> render("show.json", user: user)
    end
  end

  def show(conn, %{"userID" => id}) do
    user = Accounts.get_user!(id)
    render(conn, "show.json", user: user)
  end

  def showBy(conn, %{"email" => email, "username" => username}) do
    user = Accounts.get_user_by(email, username)
    render(conn, "show.json", user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Accounts.get_user!(id)

    with {:ok, %User{} = user} <- Accounts.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)

    with {:ok, %User{}} <- Accounts.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end
end

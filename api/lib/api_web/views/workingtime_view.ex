defmodule ApiWeb.WorkingtimeView do
  use ApiWeb, :view
  alias ApiWeb.WorkingtimeView
  alias Api.Accounts

  def render("index.json", %{workingtimes: workingtimes}) do
    %{data: render_many(workingtimes, WorkingtimeView, "workingtime.json")}
  end

  def render("show.json", %{workingtime: workingtime}) do
    %{data: render_one(workingtime, WorkingtimeView, "workingtime.json")}
  end

  def render("workingtime.json", %{workingtime: workingtime}) do
    user = Accounts.get_user!(workingtime.user_id)

    %{
      id: workingtime.id,
      start: workingtime.start,
      end: workingtime.end,
      user: %{
        username: user.username,
        email: user.email
      }
    }
  end
end

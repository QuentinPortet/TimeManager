defmodule Api.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :username, :string
    has_many :clocks, Api.Accounts.Clock
    has_many :workingtimes, Api.Accounts.Workingtime

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :email])
    |> validate_required([:username, :email])
    |> unique_constraint(:email)
    |> validate_format(:email, ~r/@/, [message: "Email format invalid bro !"])
  end
end

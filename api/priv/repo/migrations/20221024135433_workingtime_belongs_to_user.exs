defmodule Api.Repo.Migrations.WorkingtimeBelongsToUser do
  use Ecto.Migration

  def change do
    alter table(:workingtimes) do
      add :user, references(:users)
    end
  end
end

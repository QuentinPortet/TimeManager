defmodule Api.Repo.Migrations.ClockBelongsToUser do
  use Ecto.Migration

  def change do
    alter table(:clocks) do
      add :user, references(:users)
    end
  end
end

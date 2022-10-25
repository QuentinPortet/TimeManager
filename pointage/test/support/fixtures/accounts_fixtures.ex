defmodule Pointage.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Pointage.Accounts` context.
  """

  @doc """
  Generate a unique user email.
  """
  def unique_user_email, do: "some email#{System.unique_integer([:positive])}"

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        email: unique_user_email(),
        username: "some username"
      })
      |> Pointage.Accounts.create_user()

    user
  end

  @doc """
  Generate a clock.
  """
  def clock_fixture(attrs \\ %{}) do
    {:ok, clock} =
      attrs
      |> Enum.into(%{
        status: true,
        time: ~N[2022-10-24 13:53:00]
      })
      |> Pointage.Accounts.create_clock()

    clock
  end

  @doc """
  Generate a workingtime.
  """
  def workingtime_fixture(attrs \\ %{}) do
    {:ok, workingtime} =
      attrs
      |> Enum.into(%{
        end: ~N[2022-10-24 13:54:00],
        start: ~N[2022-10-24 13:54:00]
      })
      |> Pointage.Accounts.create_workingtime()

    workingtime
  end
end

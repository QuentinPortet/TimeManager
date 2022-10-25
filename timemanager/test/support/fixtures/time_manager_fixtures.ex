defmodule Timemanager.TimeManagerFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Timemanager.TimeManager` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        email: "some email",
        username: "some username"
      })
      |> Timemanager.TimeManager.create_user()

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
        time: ~U[2022-10-24 10:02:00Z]
      })
      |> Timemanager.TimeManager.create_clock()

    clock
  end

  @doc """
  Generate a clock.
  """
  def clock_fixture(attrs \\ %{}) do
    {:ok, clock} =
      attrs
      |> Enum.into(%{
        status: true,
        time: ~U[2022-10-24 10:03:00Z]
      })
      |> Timemanager.TimeManager.create_clock()

    clock
  end

  @doc """
  Generate a clock.
  """
  def clock_fixture(attrs \\ %{}) do
    {:ok, clock} =
      attrs
      |> Enum.into(%{
        status: true,
        time: ~U[2022-10-24 10:05:00Z]
      })
      |> Timemanager.TimeManager.create_clock()

    clock
  end

  @doc """
  Generate a clock.
  """
  def clock_fixture(attrs \\ %{}) do
    {:ok, clock} =
      attrs
      |> Enum.into(%{
        status: true,
        time: ~U[2022-10-24 10:07:00Z]
      })
      |> Timemanager.TimeManager.create_clock()

    clock
  end

  @doc """
  Generate a clock.
  """
  def clock_fixture(attrs \\ %{}) do
    {:ok, clock} =
      attrs
      |> Enum.into(%{
        status: true,
        time: ~U[2022-10-24 10:09:00Z]
      })
      |> Timemanager.TimeManager.create_clock()

    clock
  end

  @doc """
  Generate a clock.
  """
  def clock_fixture(attrs \\ %{}) do
    {:ok, clock} =
      attrs
      |> Enum.into(%{
        status: true,
        time: ~U[2022-10-24 10:10:00Z]
      })
      |> Timemanager.TimeManager.create_clock()

    clock
  end

  @doc """
  Generate a clock.
  """
  def clock_fixture(attrs \\ %{}) do
    {:ok, clock} =
      attrs
      |> Enum.into(%{
        status: true,
        time: ~U[2022-10-24 10:11:00Z]
      })
      |> Timemanager.TimeManager.create_clock()

    clock
  end

  @doc """
  Generate a working_times.
  """
  def working_times_fixture(attrs \\ %{}) do
    {:ok, working_times} =
      attrs
      |> Enum.into(%{
        end: ~U[2022-10-24 10:14:00Z],
        start: ~U[2022-10-24 10:14:00Z]
      })
      |> Timemanager.TimeManager.create_working_times()

    working_times
  end
end

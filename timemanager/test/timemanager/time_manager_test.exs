defmodule Timemanager.TimeManagerTest do
  use Timemanager.DataCase

  alias Timemanager.TimeManager

  describe "users" do
    alias Timemanager.TimeManager.User

    import Timemanager.TimeManagerFixtures

    @invalid_attrs %{email: nil, username: nil}

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert TimeManager.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert TimeManager.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      valid_attrs = %{email: "some email", username: "some username"}

      assert {:ok, %User{} = user} = TimeManager.create_user(valid_attrs)
      assert user.email == "some email"
      assert user.username == "some username"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = TimeManager.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      update_attrs = %{email: "some updated email", username: "some updated username"}

      assert {:ok, %User{} = user} = TimeManager.update_user(user, update_attrs)
      assert user.email == "some updated email"
      assert user.username == "some updated username"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = TimeManager.update_user(user, @invalid_attrs)
      assert user == TimeManager.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = TimeManager.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> TimeManager.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = TimeManager.change_user(user)
    end
  end

  describe "clocks" do
    alias Timemanager.TimeManager.Clock

    import Timemanager.TimeManagerFixtures

    @invalid_attrs %{status: nil, time: nil}

    test "list_clocks/0 returns all clocks" do
      clock = clock_fixture()
      assert TimeManager.list_clocks() == [clock]
    end

    test "get_clock!/1 returns the clock with given id" do
      clock = clock_fixture()
      assert TimeManager.get_clock!(clock.id) == clock
    end

    test "create_clock/1 with valid data creates a clock" do
      valid_attrs = %{status: true, time: ~U[2022-10-24 10:02:00Z]}

      assert {:ok, %Clock{} = clock} = TimeManager.create_clock(valid_attrs)
      assert clock.status == true
      assert clock.time == ~U[2022-10-24 10:02:00Z]
    end

    test "create_clock/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = TimeManager.create_clock(@invalid_attrs)
    end

    test "update_clock/2 with valid data updates the clock" do
      clock = clock_fixture()
      update_attrs = %{status: false, time: ~U[2022-10-25 10:02:00Z]}

      assert {:ok, %Clock{} = clock} = TimeManager.update_clock(clock, update_attrs)
      assert clock.status == false
      assert clock.time == ~U[2022-10-25 10:02:00Z]
    end

    test "update_clock/2 with invalid data returns error changeset" do
      clock = clock_fixture()
      assert {:error, %Ecto.Changeset{}} = TimeManager.update_clock(clock, @invalid_attrs)
      assert clock == TimeManager.get_clock!(clock.id)
    end

    test "delete_clock/1 deletes the clock" do
      clock = clock_fixture()
      assert {:ok, %Clock{}} = TimeManager.delete_clock(clock)
      assert_raise Ecto.NoResultsError, fn -> TimeManager.get_clock!(clock.id) end
    end

    test "change_clock/1 returns a clock changeset" do
      clock = clock_fixture()
      assert %Ecto.Changeset{} = TimeManager.change_clock(clock)
    end
  end

  describe "clocks" do
    alias Timemanager.TimeManager.Clock

    import Timemanager.TimeManagerFixtures

    @invalid_attrs %{status: nil, time: nil}

    test "list_clocks/0 returns all clocks" do
      clock = clock_fixture()
      assert TimeManager.list_clocks() == [clock]
    end

    test "get_clock!/1 returns the clock with given id" do
      clock = clock_fixture()
      assert TimeManager.get_clock!(clock.id) == clock
    end

    test "create_clock/1 with valid data creates a clock" do
      valid_attrs = %{status: true, time: ~U[2022-10-24 10:03:00Z]}

      assert {:ok, %Clock{} = clock} = TimeManager.create_clock(valid_attrs)
      assert clock.status == true
      assert clock.time == ~U[2022-10-24 10:03:00Z]
    end

    test "create_clock/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = TimeManager.create_clock(@invalid_attrs)
    end

    test "update_clock/2 with valid data updates the clock" do
      clock = clock_fixture()
      update_attrs = %{status: false, time: ~U[2022-10-25 10:03:00Z]}

      assert {:ok, %Clock{} = clock} = TimeManager.update_clock(clock, update_attrs)
      assert clock.status == false
      assert clock.time == ~U[2022-10-25 10:03:00Z]
    end

    test "update_clock/2 with invalid data returns error changeset" do
      clock = clock_fixture()
      assert {:error, %Ecto.Changeset{}} = TimeManager.update_clock(clock, @invalid_attrs)
      assert clock == TimeManager.get_clock!(clock.id)
    end

    test "delete_clock/1 deletes the clock" do
      clock = clock_fixture()
      assert {:ok, %Clock{}} = TimeManager.delete_clock(clock)
      assert_raise Ecto.NoResultsError, fn -> TimeManager.get_clock!(clock.id) end
    end

    test "change_clock/1 returns a clock changeset" do
      clock = clock_fixture()
      assert %Ecto.Changeset{} = TimeManager.change_clock(clock)
    end
  end

  describe "clocks" do
    alias Timemanager.TimeManager.Clock

    import Timemanager.TimeManagerFixtures

    @invalid_attrs %{status: nil, time: nil}

    test "list_clocks/0 returns all clocks" do
      clock = clock_fixture()
      assert TimeManager.list_clocks() == [clock]
    end

    test "get_clock!/1 returns the clock with given id" do
      clock = clock_fixture()
      assert TimeManager.get_clock!(clock.id) == clock
    end

    test "create_clock/1 with valid data creates a clock" do
      valid_attrs = %{status: true, time: ~U[2022-10-24 10:05:00Z]}

      assert {:ok, %Clock{} = clock} = TimeManager.create_clock(valid_attrs)
      assert clock.status == true
      assert clock.time == ~U[2022-10-24 10:05:00Z]
    end

    test "create_clock/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = TimeManager.create_clock(@invalid_attrs)
    end

    test "update_clock/2 with valid data updates the clock" do
      clock = clock_fixture()
      update_attrs = %{status: false, time: ~U[2022-10-25 10:05:00Z]}

      assert {:ok, %Clock{} = clock} = TimeManager.update_clock(clock, update_attrs)
      assert clock.status == false
      assert clock.time == ~U[2022-10-25 10:05:00Z]
    end

    test "update_clock/2 with invalid data returns error changeset" do
      clock = clock_fixture()
      assert {:error, %Ecto.Changeset{}} = TimeManager.update_clock(clock, @invalid_attrs)
      assert clock == TimeManager.get_clock!(clock.id)
    end

    test "delete_clock/1 deletes the clock" do
      clock = clock_fixture()
      assert {:ok, %Clock{}} = TimeManager.delete_clock(clock)
      assert_raise Ecto.NoResultsError, fn -> TimeManager.get_clock!(clock.id) end
    end

    test "change_clock/1 returns a clock changeset" do
      clock = clock_fixture()
      assert %Ecto.Changeset{} = TimeManager.change_clock(clock)
    end
  end

  describe "clocks" do
    alias Timemanager.TimeManager.Clock

    import Timemanager.TimeManagerFixtures

    @invalid_attrs %{status: nil, time: nil}

    test "list_clocks/0 returns all clocks" do
      clock = clock_fixture()
      assert TimeManager.list_clocks() == [clock]
    end

    test "get_clock!/1 returns the clock with given id" do
      clock = clock_fixture()
      assert TimeManager.get_clock!(clock.id) == clock
    end

    test "create_clock/1 with valid data creates a clock" do
      valid_attrs = %{status: true, time: ~U[2022-10-24 10:07:00Z]}

      assert {:ok, %Clock{} = clock} = TimeManager.create_clock(valid_attrs)
      assert clock.status == true
      assert clock.time == ~U[2022-10-24 10:07:00Z]
    end

    test "create_clock/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = TimeManager.create_clock(@invalid_attrs)
    end

    test "update_clock/2 with valid data updates the clock" do
      clock = clock_fixture()
      update_attrs = %{status: false, time: ~U[2022-10-25 10:07:00Z]}

      assert {:ok, %Clock{} = clock} = TimeManager.update_clock(clock, update_attrs)
      assert clock.status == false
      assert clock.time == ~U[2022-10-25 10:07:00Z]
    end

    test "update_clock/2 with invalid data returns error changeset" do
      clock = clock_fixture()
      assert {:error, %Ecto.Changeset{}} = TimeManager.update_clock(clock, @invalid_attrs)
      assert clock == TimeManager.get_clock!(clock.id)
    end

    test "delete_clock/1 deletes the clock" do
      clock = clock_fixture()
      assert {:ok, %Clock{}} = TimeManager.delete_clock(clock)
      assert_raise Ecto.NoResultsError, fn -> TimeManager.get_clock!(clock.id) end
    end

    test "change_clock/1 returns a clock changeset" do
      clock = clock_fixture()
      assert %Ecto.Changeset{} = TimeManager.change_clock(clock)
    end
  end

  describe "clocks" do
    alias Timemanager.TimeManager.Clock

    import Timemanager.TimeManagerFixtures

    @invalid_attrs %{status: nil, time: nil}

    test "list_clocks/0 returns all clocks" do
      clock = clock_fixture()
      assert TimeManager.list_clocks() == [clock]
    end

    test "get_clock!/1 returns the clock with given id" do
      clock = clock_fixture()
      assert TimeManager.get_clock!(clock.id) == clock
    end

    test "create_clock/1 with valid data creates a clock" do
      valid_attrs = %{status: true, time: ~U[2022-10-24 10:09:00Z]}

      assert {:ok, %Clock{} = clock} = TimeManager.create_clock(valid_attrs)
      assert clock.status == true
      assert clock.time == ~U[2022-10-24 10:09:00Z]
    end

    test "create_clock/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = TimeManager.create_clock(@invalid_attrs)
    end

    test "update_clock/2 with valid data updates the clock" do
      clock = clock_fixture()
      update_attrs = %{status: false, time: ~U[2022-10-25 10:09:00Z]}

      assert {:ok, %Clock{} = clock} = TimeManager.update_clock(clock, update_attrs)
      assert clock.status == false
      assert clock.time == ~U[2022-10-25 10:09:00Z]
    end

    test "update_clock/2 with invalid data returns error changeset" do
      clock = clock_fixture()
      assert {:error, %Ecto.Changeset{}} = TimeManager.update_clock(clock, @invalid_attrs)
      assert clock == TimeManager.get_clock!(clock.id)
    end

    test "delete_clock/1 deletes the clock" do
      clock = clock_fixture()
      assert {:ok, %Clock{}} = TimeManager.delete_clock(clock)
      assert_raise Ecto.NoResultsError, fn -> TimeManager.get_clock!(clock.id) end
    end

    test "change_clock/1 returns a clock changeset" do
      clock = clock_fixture()
      assert %Ecto.Changeset{} = TimeManager.change_clock(clock)
    end
  end

  describe "clocks" do
    alias Timemanager.TimeManager.Clock

    import Timemanager.TimeManagerFixtures

    @invalid_attrs %{status: nil, time: nil}

    test "list_clocks/0 returns all clocks" do
      clock = clock_fixture()
      assert TimeManager.list_clocks() == [clock]
    end

    test "get_clock!/1 returns the clock with given id" do
      clock = clock_fixture()
      assert TimeManager.get_clock!(clock.id) == clock
    end

    test "create_clock/1 with valid data creates a clock" do
      valid_attrs = %{status: true, time: ~U[2022-10-24 10:10:00Z]}

      assert {:ok, %Clock{} = clock} = TimeManager.create_clock(valid_attrs)
      assert clock.status == true
      assert clock.time == ~U[2022-10-24 10:10:00Z]
    end

    test "create_clock/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = TimeManager.create_clock(@invalid_attrs)
    end

    test "update_clock/2 with valid data updates the clock" do
      clock = clock_fixture()
      update_attrs = %{status: false, time: ~U[2022-10-25 10:10:00Z]}

      assert {:ok, %Clock{} = clock} = TimeManager.update_clock(clock, update_attrs)
      assert clock.status == false
      assert clock.time == ~U[2022-10-25 10:10:00Z]
    end

    test "update_clock/2 with invalid data returns error changeset" do
      clock = clock_fixture()
      assert {:error, %Ecto.Changeset{}} = TimeManager.update_clock(clock, @invalid_attrs)
      assert clock == TimeManager.get_clock!(clock.id)
    end

    test "delete_clock/1 deletes the clock" do
      clock = clock_fixture()
      assert {:ok, %Clock{}} = TimeManager.delete_clock(clock)
      assert_raise Ecto.NoResultsError, fn -> TimeManager.get_clock!(clock.id) end
    end

    test "change_clock/1 returns a clock changeset" do
      clock = clock_fixture()
      assert %Ecto.Changeset{} = TimeManager.change_clock(clock)
    end
  end

  describe "clocks" do
    alias Timemanager.TimeManager.Clock

    import Timemanager.TimeManagerFixtures

    @invalid_attrs %{status: nil, time: nil}

    test "list_clocks/0 returns all clocks" do
      clock = clock_fixture()
      assert TimeManager.list_clocks() == [clock]
    end

    test "get_clock!/1 returns the clock with given id" do
      clock = clock_fixture()
      assert TimeManager.get_clock!(clock.id) == clock
    end

    test "create_clock/1 with valid data creates a clock" do
      valid_attrs = %{status: true, time: ~U[2022-10-24 10:11:00Z]}

      assert {:ok, %Clock{} = clock} = TimeManager.create_clock(valid_attrs)
      assert clock.status == true
      assert clock.time == ~U[2022-10-24 10:11:00Z]
    end

    test "create_clock/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = TimeManager.create_clock(@invalid_attrs)
    end

    test "update_clock/2 with valid data updates the clock" do
      clock = clock_fixture()
      update_attrs = %{status: false, time: ~U[2022-10-25 10:11:00Z]}

      assert {:ok, %Clock{} = clock} = TimeManager.update_clock(clock, update_attrs)
      assert clock.status == false
      assert clock.time == ~U[2022-10-25 10:11:00Z]
    end

    test "update_clock/2 with invalid data returns error changeset" do
      clock = clock_fixture()
      assert {:error, %Ecto.Changeset{}} = TimeManager.update_clock(clock, @invalid_attrs)
      assert clock == TimeManager.get_clock!(clock.id)
    end

    test "delete_clock/1 deletes the clock" do
      clock = clock_fixture()
      assert {:ok, %Clock{}} = TimeManager.delete_clock(clock)
      assert_raise Ecto.NoResultsError, fn -> TimeManager.get_clock!(clock.id) end
    end

    test "change_clock/1 returns a clock changeset" do
      clock = clock_fixture()
      assert %Ecto.Changeset{} = TimeManager.change_clock(clock)
    end
  end

  describe "workingtimes" do
    alias Timemanager.TimeManager.WorkingTimes

    import Timemanager.TimeManagerFixtures

    @invalid_attrs %{end: nil, start: nil}

    test "list_workingtimes/0 returns all workingtimes" do
      working_times = working_times_fixture()
      assert TimeManager.list_workingtimes() == [working_times]
    end

    test "get_working_times!/1 returns the working_times with given id" do
      working_times = working_times_fixture()
      assert TimeManager.get_working_times!(working_times.id) == working_times
    end

    test "create_working_times/1 with valid data creates a working_times" do
      valid_attrs = %{end: ~U[2022-10-24 10:14:00Z], start: ~U[2022-10-24 10:14:00Z]}

      assert {:ok, %WorkingTimes{} = working_times} = TimeManager.create_working_times(valid_attrs)
      assert working_times.end == ~U[2022-10-24 10:14:00Z]
      assert working_times.start == ~U[2022-10-24 10:14:00Z]
    end

    test "create_working_times/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = TimeManager.create_working_times(@invalid_attrs)
    end

    test "update_working_times/2 with valid data updates the working_times" do
      working_times = working_times_fixture()
      update_attrs = %{end: ~U[2022-10-25 10:14:00Z], start: ~U[2022-10-25 10:14:00Z]}

      assert {:ok, %WorkingTimes{} = working_times} = TimeManager.update_working_times(working_times, update_attrs)
      assert working_times.end == ~U[2022-10-25 10:14:00Z]
      assert working_times.start == ~U[2022-10-25 10:14:00Z]
    end

    test "update_working_times/2 with invalid data returns error changeset" do
      working_times = working_times_fixture()
      assert {:error, %Ecto.Changeset{}} = TimeManager.update_working_times(working_times, @invalid_attrs)
      assert working_times == TimeManager.get_working_times!(working_times.id)
    end

    test "delete_working_times/1 deletes the working_times" do
      working_times = working_times_fixture()
      assert {:ok, %WorkingTimes{}} = TimeManager.delete_working_times(working_times)
      assert_raise Ecto.NoResultsError, fn -> TimeManager.get_working_times!(working_times.id) end
    end

    test "change_working_times/1 returns a working_times changeset" do
      working_times = working_times_fixture()
      assert %Ecto.Changeset{} = TimeManager.change_working_times(working_times)
    end
  end
end

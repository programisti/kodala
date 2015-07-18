defmodule Kodala.BlahControllerTest do
  use Kodala.ConnCase

  alias Kodala.Blah
  @valid_attrs %{param1: "some content", param2: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn()
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, blah_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing blahs"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, blah_path(conn, :new)
    assert html_response(conn, 200) =~ "New blah"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, blah_path(conn, :create), blah: @valid_attrs
    assert redirected_to(conn) == blah_path(conn, :index)
    assert Repo.get_by(Blah, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, blah_path(conn, :create), blah: @invalid_attrs
    assert html_response(conn, 200) =~ "New blah"
  end

  test "shows chosen resource", %{conn: conn} do
    blah = Repo.insert! %Blah{}
    conn = get conn, blah_path(conn, :show, blah)
    assert html_response(conn, 200) =~ "Show blah"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, blah_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    blah = Repo.insert! %Blah{}
    conn = get conn, blah_path(conn, :edit, blah)
    assert html_response(conn, 200) =~ "Edit blah"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    blah = Repo.insert! %Blah{}
    conn = put conn, blah_path(conn, :update, blah), blah: @valid_attrs
    assert redirected_to(conn) == blah_path(conn, :index)
    assert Repo.get_by(Blah, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    blah = Repo.insert! %Blah{}
    conn = put conn, blah_path(conn, :update, blah), blah: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit blah"
  end

  test "deletes chosen resource", %{conn: conn} do
    blah = Repo.insert! %Blah{}
    conn = delete conn, blah_path(conn, :delete, blah)
    assert redirected_to(conn) == blah_path(conn, :index)
    refute Repo.get(Blah, blah.id)
  end
end

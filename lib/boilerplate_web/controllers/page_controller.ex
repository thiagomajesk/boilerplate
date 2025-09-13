defmodule BoilerplateWeb.PageController do
  use BoilerplateWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end

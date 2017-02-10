defmodule Revolution.PageController do
  use Revolution.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end

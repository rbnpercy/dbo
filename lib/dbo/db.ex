defmodule Dbo.DB do
@moduledoc """
  Database interface module.  Start connection, Stop connection & Query.
"""

  alias Dbo.DB.Format

  @default_port 5432
  @default_host "localhost"
 
  ##
  #   CONNECTION
  ##
  @spec connect(String.t, String.t, String.t) :: {:ok, pid}
  def connect(db, user, pass) do
    do_connect(username: user, password: pass, database: db)
  end

  def do_connect(opts) do
    extensions = [{Postgrex.Extensions.JSON, library: Poison}]

    opts = opts
      |> Keyword.put(:hostname, Application.get_env(:postgrex, :hostname) || @default_host)
      |> Keyword.update(:extensions, extensions, &(&1 ++ extensions))
      |> Keyword.update(:port, @default_port, &normalize_port/1)

    Postgrex.Connection.start_link(opts)
  end

  defp normalize_port(port) when is_binary(port), do: String.to_integer(port)
  defp normalize_port(port) when is_integer(port), do: port


  @spec disconnect(pid) :: :ok
  def disconnect(conn) do
    try do
      Postgrex.Connection.stop(conn)
    catch
      :exit, {:noproc, _} -> :ok
    end
    :ok
  end


  ##
  #   QUERYING
  ##
  @spec query(String.t, String.t, Keyword.t) :: {:ok, Map}
  def query(db, sql, opts) do
    case Postgrex.Connection.query!(db, sql, opts) do
      %Postgrex.Result{} = res   -> Format.handle_results(res)
      %Postgrex.Error{} = err    -> err
    end
  end

end

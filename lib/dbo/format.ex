defmodule Dbo.DB.Format do
@moduledoc """
  Formatter module.  Return query results in an actually usuable format.
"""

  @doc """
    Handle results depending on DB action performed in the query.
  """
  def handle_results(res) do
    case res.command do
      :insert ->
        handle_insert(res)
      :select ->
        handle_select(res)
    end
  end

 
  @doc """
    Handle the insert query return.  Returning the ID && Success message.
  """
  def handle_insert(res) do
    rr = res.rows
      |> List.first
      |> Tuple.to_list
      |> List.insert_at(1, "success: true")
  end


  @doc """
    Handle select result set depending on num_rows returned in the query.
  """
  def handle_select(res) do
    case res.num_rows do
      1 ->
        handle_single_result(res.rows)
      0 ->
        false
      _ ->
        handle_multiple(res.rows)
    end
  end


  def handle_single_result(res) do
    rr = List.first(res)
    Tuple.to_list(rr) |> List.first
    # ya
  end


  def handle_multiple(res) do
    Enum.map(res, fn (x) -> Tuple.to_list(x)
      |> List.first
    end)
  end

end

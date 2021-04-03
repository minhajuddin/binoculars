defmodule BinocularsWeb.PageLive do
  use BinocularsWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, pid: self() |> inspect()), temporary_assigns: [columns: [], rows: [], number_of_rows: 0] }
  end

  @impl true
  def handle_event("execute", %{"query" => query}, socket) do
    result_set = Ecto.Adapters.SQL.query!(
      Binoculars.Repo, query, []
    )
    IO.puts "EXECUTING #{ query }"
    {:noreply, assign(socket, columns: result_set.columns, rows: result_set.rows, number_of_rows: result_set.num_rows)
    }
  end

  def handle_event(event, params, socket) do
    Logger.info 
    {:noreply, assign(socket, columns: result_set.columns, rows: result_set.rows, number_of_rows: result_set.num_rows)}
  end


end

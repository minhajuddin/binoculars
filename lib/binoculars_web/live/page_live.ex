defmodule BinocularsWeb.PageLive do
  use BinocularsWeb, :live_view
  require Logger

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, query: "", error: nil),
     temporary_assigns: [columns: [], rows: [], number_of_rows: 0]}
  end

  @impl true
  def handle_event("execute", %{"query" => query}, socket) do
    {:noreply, execute_and_assign(socket, query)}
  end

  def handle_event(
        "execute",
        %{"ctrlKey" => ctrl, "key" => "Enter", "metaKey" => meta, "value" => query},
        socket
      )
      when ctrl or meta do
    {:noreply, execute_and_assign(socket, query)}
  end

  def handle_event(event, params, socket) do
    Logger.info(code: "UNHANDLED", event: event, params: params)
    {:noreply, socket}
  end

  defp execute_and_assign(socket, query) do
    try do
      result_set =
        Ecto.Adapters.SQL.query!(
          Binoculars.Repo,
          query,
          []
        )

      assign(socket,
        query: query,
        columns: result_set.columns,
        rows: result_set.rows,
        number_of_rows: result_set.num_rows,
        error: nil
      )
    rescue
      ex in Postgrex.Error ->
        assign(socket,
          error: ex.message
        )
    end
  end
end

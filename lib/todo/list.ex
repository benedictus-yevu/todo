defmodule Todo.List do
  defstruct [auto_id: 1, entries: %{}]

  def new() do
    %Todo.List{}
  end

  def add_entry(todo_list,entry) do
    entry = Map.put(entry, :id, todo_list.auto_id)
    new_entry = Map.put(todo_list.entries, entry.id, entry)
    %Todo.List{todo_list | entries: new_entry, auto_id: todo_list.auto_id + 1}
  end


  def entries(todo_list,date) do
    todo_list.entries
    |> Stream.filter(fn {_key,value} -> value.date === date end)
    |> Enum.map(fn {_,value} -> value end)
  end

  def update_entry(todo_list,entry_id,value) do
    case Map.fetch(todo_list.entries, entry_id) do
      {:ok, _old_todo} ->
        new_entries = put_in(todo_list.entries[entry_id].title, value)
        %Todo.List{todo_list | entries: new_entries}
      :error ->
        todo_list
    end
  end
end

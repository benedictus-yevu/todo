defmodule Todo.Server do
  use GenServer

  def start do
    GenServer.start(__MODULE__,Todo.List.new, name: __MODULE__)
  end

  def init(state) do
    {:ok, state}
  end

  #interface functions

  def add_entry(todo_pid,entry) do
    GenServer.cast(todo_pid,{:add_entry,entry})
  end

  def update_entry(todo_pid,entry_id,value) do
    GenServer.call(todo_pid,{:update,entry_id,value})
  end

  def all(todo_pid) do
    GenServer.call(todo_pid,{:all})
  end
  def entries(todo_pid,date) do
    GenServer.call(todo_pid,{:entries,date})
  end

  def stop_server(todo_pid) do
    GenServer.stop(todo_pid)
  end

  #callbacks
  def handle_cast({:add_entry,entry},state) do
    {:noreply, Todo.List.add_entry(state,entry)}
  end

  def handle_call({:update,entry_id,value},_,state) do
    new_entry = Todo.List.update_entry(state,entry_id,value)
    {:reply, new_entry, new_entry}
  end

  def handle_call({:entries,date},_,state) do
    {:reply, Todo.List.entries(state,date),state}
  end

  def handle_call({:all},_,state) do
    # {:reply, state,state}
    if state do
      {:reply,state,state}
    else
      {:reply,{:error,"no running server process"},nil}
    end
  end





end

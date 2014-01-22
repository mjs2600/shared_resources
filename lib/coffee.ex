defmodule Coffee do
  def start_link do
    {:ok, spawn_link(Coffee, :init, [])}
  end

  def init do
    IO.puts "Brewin' coffee..."
    response = System.cmd("coffee -wj priv/static/js/application.js -c priv/static/coffee/*.coffee")
    IO.puts response
    IO.puts "Coffee updated..."
  end
end

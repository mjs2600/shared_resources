defmodule Coffee do
  def run do
    IO.puts "Compilin' coffee..."
    System.cmd("coffee -wj priv/static/js/compiled/application.js -c priv/static/coffee/*.coffee")
    IO.puts "Please install coffee-script!"
  end
end

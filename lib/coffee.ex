defmodule Coffee do
  def run do
    System.cmd("coffee -wj priv/static/js/compiled/application.js -c priv/static/coffee/*.coffee")
  end
end

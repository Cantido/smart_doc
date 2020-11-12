defmodule Mix.Tasks.SmartDoc do
  use Mix.Task

  def run([filename]) do
    contents = File.read!(filename)

    results = SmartDoc.validate(contents)

    Enum.map(results, fn result ->
      """
      Rule violation: #{inspect result.rule}
      Context: #{inspect result.context}
      """
    end)
    |> Enum.join("\n----\n")
    |> IO.puts()
  end
end

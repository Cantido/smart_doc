defmodule SmartDoc do
  @moduledoc """
  Documentation for `SmartDoc`.
  """

  @doc """
  Checks English text for simplicity.

  Returns a list of rule violations.

  ## Examples

      iex> SmartDoc.validate("This is a simple sentence.")
      []

  """
  def validate(text, opts \\ []) do
    [
      SmartDoc.Rules.ShortParagraphs,
      SmartDoc.Rules.ShortSentences,
      SmartDoc.Rules.CommonWords
    ]
    |> Enum.map(fn mod ->
      Task.async(mod, :evaluate, [text, opts])
    end)
    |> Task.await_many()
    |> List.flatten()
  end
end

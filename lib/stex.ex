defmodule Stex do
  @moduledoc """
  Documentation for `Stex`.
  """

  @doc """
  Checks English text for simplicity.

  Returns a list of rule violations.

  ## Examples

      iex> Stex.validate("This is a simple sentence.")
      []

  """
  def validate(text, opts \\ []) do
    [
      Stex.Rules.ShortParagraphs,
      Stex.Rules.ShortSentences,
      Stex.Rules.CommonWords
    ]
    |> Enum.map(fn mod ->
      Task.async(mod, :evaluate, [text, opts])
    end)
    |> Task.await_many()
    |> List.flatten()
  end
end

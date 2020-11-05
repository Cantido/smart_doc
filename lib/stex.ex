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
  def validate(text) do
    sentences =
      text
      |> String.split(~r/\.[\s\r\n]*/)
      |> Enum.reject(&String.length(&1) == 0)
      |> Enum.map(&String.split/1)
      |> Enum.flat_map(fn words ->
        if Enum.count(words) > 25 do
          [%{
            rule: :write_short_sentences,
            context: Enum.slice(words, 21..27) |> Enum.join(" ")
          }]
        else
          []
        end
      end)

  end
end

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
    short_sentences_rule(text) ++ short_paragraphs_rule(text)
  end

  defp short_sentences_rule(text) do
    text
    |> String.split(~r/\.[\s\r\n]+/, trim: true)
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

  defp short_paragraphs_rule(text) do
    paragraphs =
      text
      |> String.split(~r/[\r\n]{2,}/, trim: true)

    paragraphs
    |> Enum.map(&String.split(&1, ~r/\.[\s\r\n]+/, trim: true))
    |> Enum.flat_map(fn sentences ->
      if Enum.count(sentences) > 6 do
        context = Enum.slice(sentences, 5..6) |> Enum.join(". ") |> String.replace("\n", " ")
        [%{
          rule: :write_short_paragraphs,
          context: context <> "."
        }]
      else
        []
      end
    end)
  end
end

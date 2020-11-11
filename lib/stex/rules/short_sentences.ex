defmodule Stex.Rules.ShortSentences do
  def evaluate(text, _opts) do
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
end

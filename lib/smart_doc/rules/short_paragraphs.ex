defmodule SmartDoc.Rules.ShortParagraphs do
  @behaviour SmartDoc.Rule

  def evaluate(text, _opts) do
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

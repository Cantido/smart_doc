defmodule Stex.Rules.CommonWords do
  @behaviour Stex.Rule

  @external_resource common_words_path = Path.join(__DIR__, ["wordlists/common_words.txt"])
  @external_resource technical_words_path = Path.join(__DIR__, ["wordlists/technical_words.txt"])

  for entry <- File.stream!(common_words_path, [], :line) do
    word = to_string(entry) |> String.split(" ") |> List.first() |> String.trim()
    defp common?(unquote(word)), do: unquote(true)
  end

  for entry <- File.stream!(technical_words_path, [], :line) do
    word = to_string(entry) |> String.split(" ") |> List.first() |> String.trim()
    defp common?(unquote(word)), do: unquote(true)
  end

  defp common?(_), do: false

  def evaluate(text, opts) do
    ignored_words = Keyword.get(opts, :ignored_words, []) |> Enum.map(&String.downcase/1)

    text
    |> String.split(~r/\.[\s\r\n]+/, trim: true)
    |> Enum.flat_map(&String.split/1)
    |> Enum.reject(&(&1 in ~w(- *)))
    |> Enum.flat_map(fn word ->
      cleaned_word = String.replace(word, ~w(\( \) . , \"), "")
      code_word? = String.match?(cleaned_word, ~r/`.*`/) or String.match?(cleaned_word, ~r/`.*/) or String.match?(cleaned_word, ~r/.*`/)
      permutations = permutations(String.downcase(cleaned_word))
      based_on_common_word? = Enum.any?(permutations, &common?/1)
      ignored_word? = Enum.any?(permutations, &(&1 in ignored_words))

      if ignored_word? or based_on_common_word? or code_word? do
        []
      else
        [%{
          rule: :use_common_words,
          context: word,
          permutations_tried: permutations
        }]
      end
    end)
  end

  defp permutations(word) do
    [
      String.replace_suffix(word, "ed", ""),
      String.replace_suffix(word, "ed", "e"),
      String.replace_suffix(word, "er", ""),
      String.replace_suffix(word, "ies", "y"),
      String.replace_suffix(word, "ied", "y"),
      String.replace_suffix(word, "itten", "ite"),
      String.replace_suffix(word, "ing", ""),
      String.replace_suffix(word, "ing", "e"),
      String.replace_suffix(word, "ity", "e"),
      String.replace_suffix(word, "ler", "er"),
      String.replace_suffix(word, "ly", ""),
      String.replace_suffix(word, "ter", "t"),
      String.replace_suffix(word, "s", "")
    ]
    |> Enum.uniq()
  end
end

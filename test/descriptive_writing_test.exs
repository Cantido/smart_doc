defmodule Stex.DescriptiveWritingTest do
  use ExUnit.Case

  describe "sentence maximum length" do
    test "flags sentences with more than 25 words in them" do
      [error] = Stex.validate("""
      A smartphone is a cellular telephone that has an integrated computer and many other qualities,
      such as an operating system, internet browsing as well as the ability to run software applications.
      """)

      assert error == %{
        rule: :write_short_sentences,
        context: "browsing as well as the ability to"
      }
    end
  end
end

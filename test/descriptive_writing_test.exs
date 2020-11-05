defmodule Stex.DescriptiveWritingTest do
  use ExUnit.Case

  describe "sentence maximum length" do
    test "flags sentences with more than 25 words in them" do
      [error] = Stex.validate("""
      Using the "topic:subtopic" approach pairs nicely with the
      Phoenix.Socket.channel/3 allowing you to match on all topics starting
      with a given prefix by using a splat (the * character) as the last
      character in the topic pattern
      """)

      assert error == %{
        rule: :write_short_sentences,
        context: "by using a splat (the * character)"
      }
    end
  end

  describe "paragraph maximum length" do
    test "passes multiple paragraphs each with six or fewer sentences" do
      errors = Stex.validate("""
      Phoenix is a web development framework written in Elixir which implements
      the server-side Model View Controller (MVC) pattern. Many of its
      components and concepts will seem familiar to those of us with experience
      in other web frameworks.

      Phoenix provides the best of both worlds - high developer productivity
      and high application performance. It also has some interesting new twists
      like channels for implementing realtime features and pre-compiled
      templates for blazing speed.
      """)

      assert errors == []
    end

    test "flags a paragraph with more than six sentences" do
      [error] = Stex.validate("""
      - deps - a directory with all of our Mix dependencies. You can find all
      dependencies listed in the mix.exs file, inside the def deps do function
      definition. This directory must not be checked into version control and
      it can be removed at any time. Removing it will force Mix to download all
      deps from scratch

      - lib - a directory that holds your application source code. This
      directory is broken into two subdirectories, lib/hello and lib/hello_web.
      The lib/hello directory will be responsible to host all of your business
      logic and business domain. It typically interacts directly with the
      database - it is the "Model" in Model-View-Controller (MVC) architecture.
      lib/hello_web is responsible for exposing your business domain to the
      world, in this case, through a web application. It holds both the View
      and Controller from MVC. We will discuss the contents of these
      directories with more detail in the next sections.
      """)

      assert error == %{
        rule: :write_short_paragraphs,
        context: "It holds both the View and Controller from MVC. We will discuss the contents of these directories with more detail in the next sections."
      }
    end
  end
end

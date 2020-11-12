defmodule SmartDoc.MixProject do
  use Mix.Project

  def project do
    [
      app: :smart_doc,
      description: "Helps you write simple technical documentation.",
      package: package(),
      docs: docs(),
      version: "0.1.0",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  defp package do
    [
      maintainers: ["Rosa Richter"],
      licenses: ["MIT"],
      links: %{"Github" => "https://github.com/Cantido/smart_doc"}
    ]
  end

  def docs do
    [
      source_url: "https://github.com/Cantido/smart_doc"
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, "~> 0.14", only: :dev, runtime: false}
    ]
  end
end

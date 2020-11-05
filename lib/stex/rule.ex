defmodule Stex.Rule do
  @callback evaluate(String.t()) :: list(map())
end

defmodule Stex.Rule do
  @callback evaluate(String.t(), list(any())) :: list(map())
end

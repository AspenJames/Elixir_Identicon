defmodule Identicon do
  @moduledoc """
  Generates an Identicon based on a passed-in string
  """

  def main(input) do
    input
    |> hash_input
  end

  @doc """
  Converts the passed-in string to a list of numbers based on the MD5 hash of the string

  ## Examples 

      iex> Identicon.hash_input "identicon"
      [173, 43, 65, 97, 60, 135, 2, 181, 55, 43, 189, 201, 168, 16, 112, 64]
      
  """
  def hash_input(input) do
    :crypto.hash(:md5, input)
    |> :binary.bin_to_list
  end
end

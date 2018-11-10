defmodule Identicon do
  @moduledoc """
  Generates an Identicon based on a passed-in string
  """

  def main(input) do
    input
    |> hash_input
    |> pick_color
  end

  @doc """
  Converts the passed-in string to a list of numbers based on the MD5 hash of the string, then stores that in an `%Identicon.Image{}` struct, setting that list as the `hex` value

  ## Examples 

      iex> Identicon.hash_input("identicon")
      %Identicon.Image{
        hex: [173, 43, 65, 97, 60, 135, 2, 181, 55, 43, 189, 201, 168, 16, 112, 64]
      }
      
  """
  def hash_input(input) do
    hex = :crypto.hash(:md5, input)
    |> :binary.bin_to_list

    %Identicon.Image{hex: hex}
  end

  @doc """
  Takes in an %Identicon.Image{} and returns the first three elements of the hex list property, setting those as a color property

  ## Examples 

      iex> image = Identicon.hash_input("identicon")
      iex> Identicon.pick_color(image)
      %Identicon.Image{
             color: {173, 43, 65},
             hex: [173, 43, 65, 97, 60, 135, 2, 181, 55, 43, 189, 201, 168, 16, 112, 64]
           }

  """
  def pick_color(%Identicon.Image{hex: [r, g, b | _]} = image) do
    %Identicon.Image{image | color: {r, g, b}}
  end
end

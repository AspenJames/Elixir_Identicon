defmodule Identicon do
  @moduledoc """
  Generates an Identicon based on a passed-in string
  """
  @doc """
  This simply runs all of the helper functions in order. Accepts an argument of a string and returns a generated Identicon
  """
  def main(input) do
    input
    |> hash_input
    |> pick_color
    |> build_grid
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
  Takes in an `%Identicon.Image{}` and returns the first three elements of the hex list property, setting those as a color property

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

  @doc """
  Takes in an argument of `%Identicon.Image{}`, chunks the `hex` property into sub-lists of length 3, and "mirrors" them across the center

  ## Examples

      iex> image = Identicon.hash_input("identicon")
      iex> Identicon.build_grid(image)
      [
        [173, 43, 65, 43, 173],
        [97, 60, 135, 60, 97],
        [2, 181, 55, 181, 2],
        [43, 189, 201, 189, 43],
        [168, 16, 112, 16, 168]
      ]
  """
  def build_grid(%Identicon.Image{hex: hex} = image) do
    hex
    |> Enum.chunk(3)
    |> Enum.map(&mirror_row/1)
  end

  @doc """
  "Mirrors" a list of elements across the center.

  ## Examples

      iex> Identicon.mirror_row([173, 43, 65])
      [173, 43, 65, 43, 173]

  """
  def mirror_row(row) do
    [first, second | _] = row
    row ++ [second, first]
  end
end

defmodule AdventOfCode.Day06 do
  @data "nppdvjthqldpwncqszvftbrmjlhg"
  @data AdventOfCode.Input.get!(6, 2022)
  |> String.codepoints

  def part1(_args) do
    relevant_bitstream = Enum.reduce_while(@data, @data, fn x, acc ->
      window = Enum.take(acc, 4)
      if MapSet.size(MapSet.new(window)) < 4, do: {:cont, acc = List.pop_at(acc, 0) |> elem(1)}, else: {:halt, Enum.drop(acc, 4)}
    end)

    Enum.count(@data) - Enum.count(relevant_bitstream)
  end

  def part2(_args) do
  end
end

# object Day06 {

#   fun part1(input: String) = findUniqueMarker(input, 4)

#   fun part2(input: String) = findUniqueMarker(input, 14)

#   private fun findUniqueMarker(input: String, size: Int): Int {
#     return input
#       .windowed(size)
#       .indexOfFirst { it.toSet().size == size } + size
#   }

# }

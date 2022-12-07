defmodule AdventOfCode.Day06 do
  @data AdventOfCode.Input.get!(6, 2022)
  |> String.codepoints

  def find_packet_start(size) do
    relevant_bitstream = Enum.reduce_while(@data, @data, fn _x, acc ->
      window = Enum.take(acc, size)
      if MapSet.size(MapSet.new(window)) < size,
        do: {:cont, acc = List.pop_at(acc, 0) |> elem(1)},
        else: {:halt, Enum.drop(acc, size)}
    end)

    Enum.count(@data) - Enum.count(relevant_bitstream)
  end

  def part1(_args) do
    find_packet_start(4)
  end

  def part2(_args) do
    find_packet_start(14)
  end
end

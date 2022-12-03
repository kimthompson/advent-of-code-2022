defmodule AdventOfCode.Day03 do
  @data AdventOfCode.Input.get!(3, 2022)
    |> String.split("\n", trim: true)

  @values "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
    |> String.split("", trim: true)
    |> Enum.with_index()
    |> Enum.map(fn {key, value} -> {key, value + 1} end)

  def calculate_priority(x) do
    Enum.find(@values, fn {key, _value} -> key == x end)
      |> elem(1)
  end

  def part1(_args) do
    # For each row (rucksack)
    misplacedItems = Enum.reduce(@data, [], fn x, acc ->

      # Split in half (compartments)
      [compartmentOne, compartmentTwo] = x
        |> String.codepoints
        |> Enum.chunk_every(div(String.length(x), 2))

      # Find the items they have in common
      common = MapSet.intersection(MapSet.new(compartmentOne), MapSet.new(compartmentTwo))
        |> MapSet.to_list()

      # Keep track
      acc ++ common
    end)

    # Convert these items to priority values and sum
    Enum.reduce(misplacedItems, 0, fn x, acc ->
      Enum.find(@values, fn {key, _value} -> key == x end)
        |> elem(1)
        |> Kernel.+(acc)
    end)
  end

  def part2(_args) do
  end
end

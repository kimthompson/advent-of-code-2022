defmodule AdventOfCode.Day03 do
  @data AdventOfCode.Input.get!(3, 2022)
    |> String.split("\n", trim: true)

  @values "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
    |> String.split("", trim: true)
    |> Enum.with_index()
    |> Enum.map(fn {key, value} -> {key, value + 1} end)

  def part1(_args) do
    # For each row (rucksack), split in half (compartments)
    firstRucksackCompartmentSize = List.first(@data)
      |> String.length()
      |> div(2)

    firstRucksack = List.first(@data)
      |> String.codepoints
      |> Enum.chunk_every(firstRucksackCompartmentSize)

    [compartmentOne, compartmentTwo | _rest] = firstRucksack

    # Compare each of these strings(compartments) to find common characters (items), and return a list of these
    misplacedItems = MapSet.intersection(MapSet.new(compartmentOne), MapSet.new(compartmentTwo))

    # Convert these characters to numbers and sum
    Enum.reduce(misplacedItems, 0, fn x, acc ->
      Enum.find(@values, fn {key, val} -> key == x end)
        |> elem(1)
    end)

  end

  def part2(_args) do
  end
end

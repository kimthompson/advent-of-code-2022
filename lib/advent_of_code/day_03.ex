defmodule AdventOfCode.Day03 do
  @data AdventOfCode.Input.get!(3, 2022)
    |> String.split("\n", trim: true)

  @values "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
    |> String.split("", trim: true)
    |> Enum.with_index()
    |> Enum.map(fn {key, value} -> {key, value + 1} end)

  def score_items(items) do
    Enum.reduce(items, 0, fn x, acc ->
      priority = Enum.find(@values, fn {key, _value} -> key == x end)
        |> elem(1)
        priority + acc
    end)
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
    score_items(misplacedItems)
  end

  def part2(_args) do
    # Split the elves into their groups of 3
    elf_groups = Stream.chunk_every(@data, 3) |> Enum.to_list()

    # For each group
    badges = Enum.reduce(elf_groups, [], fn x, acc ->

      # Search for the common element between all of them -- the badge
      [first, second, third] = Enum.map(x, fn b -> MapSet.new(String.codepoints(b)) end)
      badge = MapSet.intersection(MapSet.intersection(first, second), third)
        |> MapSet.to_list()

      # Keep track
      acc ++ badge
    end)

    # Convert these items to priority values and sum
    score_items(badges)
  end
end

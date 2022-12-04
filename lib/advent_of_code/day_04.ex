defmodule AdventOfCode.Day04 do
  @data AdventOfCode.Input.get!(4, 2022)
    |> String.split("\n", trim: true)

  def convert_to_ranges(assignments) do
    [first_assignment, second_assignment] = assignments

    [first_beginning, first_ending] = String.split(first_assignment, "-")
    [second_beginning, second_ending] = String.split(second_assignment, "-")

    first_range = MapSet.new(Enum.to_list(String.to_integer(first_beginning)..String.to_integer(first_ending)))
    second_range = MapSet.new(Enum.to_list(String.to_integer(second_beginning)..String.to_integer(second_ending)))

    [first_range, second_range]
  end

  def part1(_args) do
    Enum.reduce(@data, [], fn elf_pair, acc ->
      assignments = elf_pair
        |> String.split(",")
        |> convert_to_ranges()

      acc ++ [MapSet.subset?(List.first(assignments), List.last(assignments)) || MapSet.subset?(List.last(assignments), List.first(assignments))]
    end)
    |> Enum.count(&(&1))
  end

  def part2(_args) do
    Enum.reduce(@data, [], fn elf_pair, acc ->
      assignments = elf_pair
        |> String.split(",")
        |> convert_to_ranges()

      has_overlap = MapSet.size(MapSet.intersection(MapSet.new(List.first(assignments)), MapSet.new(List.last(assignments)))) > 0

      acc ++ [has_overlap]
    end)
    |> Enum.count(&(&1))
  end
end

defmodule AdventOfCode.Day01 do

  # Split a string into integers and add them up
  def sum_calories(snacks) do
    Enum.sum(Enum.map(String.split(snacks, "\n", trim: true), fn (snack) -> String.to_integer(snack) end))
  end

  def get_elves do
    input = AdventOfCode.Input.get!(1)
    Enum.with_index(String.split(input, "\n\n", trim: true))
  end

  def part1(_args) do
    elves = get_elves()

    # Assign each elf a name and sum the calories in their snacks
    elf_packs = Enum.map(elves, fn ({snacks, name}) -> %{
      :calories => sum_calories(snacks),
      :name => name + 1
    } end)

    # Figure out which pack has the most calories
    Enum.max_by(elf_packs, fn pack -> pack[:calories] end)[:calories]
  end

  def part2(_args) do
    elves = get_elves()

    # Assign each elf a name and sum the calories in their snacks
    elf_packs = Enum.map(elves, fn({snacks, name}) -> %{
      :calories => sum_calories(snacks),
      :name => name + 1
    } end)

    # Figure out which three elves have the most calories (sort descending, then grab first three)
    most_prepared_elves = Enum.take(Enum.sort_by(elf_packs, &(&1[:calories]), &>=/2), 3)

    # Return the sum of those calories
    Enum.sum(Enum.map(most_prepared_elves, fn elf -> elf.calories end))
  end
end

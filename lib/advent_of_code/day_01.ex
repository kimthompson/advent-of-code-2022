defmodule AdventOfCode.Day01 do
  def part1(_args) do
    # Get the input data
    # input = "1000\n2000\n3000\n\n4000\n\n5000\n6000\n\n7000\n8000\n9000\n\n10000"
    input = AdventOfCode.Input.get!(1)

    # Split on each elf
    elves = Enum.with_index(String.split(input, "\n\n", trim: true))

    # Assign each elf a name and sum the calories in their snacks
    elf_packs = Enum.map(elves, fn ({snacks, name}) -> %{
      :calories => sum_calories(snacks),
      :name => name + 1
    } end)

    # Figure out which pack has the most calories
    Enum.max_by(elf_packs, fn pack -> pack[:calories] end)[:calories]
  end

  def sum_calories(snacks) do
    Enum.sum(Enum.map(String.split(snacks, "\n", trim: true), fn (snack) -> String.to_integer(snack) end))
  end

  def part2(_args) do
  end
end

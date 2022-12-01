defmodule AdventOfCode.Day01 do

  input = AdventOfCode.Input.get!(1)
  IO.puts(input)

  def part1(_args) do
    # Walk through each line of input
    # Your first key should be 1, while its value will be the sum of each line you've passed UNTIL
    # You hit a newline, in which case a new key (2) will be created and a new sum (0) will be started
    # Once you have this result, simply find whichever elf has the most calories
  end

  def part2(_args) do
  end
end

defmodule AdventOfCode.Day01 do

  @data AdventOfCode.Input.get!(1, 2022)
    |> String.split("\n\n", trim: true)
    |> Enum.with_index()

  def rank_elves(elves) do
    Enum.sort_by(
      Enum.map(elves, fn ({snacks, name}) -> %{
        :calories => Enum.sum(Enum.map(String.split(snacks, "\n", trim: true), fn s -> String.to_integer(s) end)),
        :name => name + 1
      } end
    ), &(&1[:calories]), &>=/2)
  end

  def part1(_args) do
    [%{calories: calories} | _others] = rank_elves(@data)
    calories
  end

  def part2(_args) do
    Enum.sum(Enum.map(Enum.take(rank_elves(@data), 3), &(&1.calories)))
  end

end

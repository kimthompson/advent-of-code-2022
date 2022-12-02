defmodule AdventOfCode.Day01 do

  def get_elves do
    input = AdventOfCode.Input.get!(1)
    Enum.with_index(String.split(input, "\n\n", trim: true))
  end

  def sum_calories(snacks) do
    Enum.sum(Enum.map(String.split(snacks, "\n", trim: true), fn s -> String.to_integer(s) end))
  end

  def rank_elves(elves) do
    Enum.sort_by(Enum.map(elves, fn ({snacks, name}) -> %{
      :calories => sum_calories(snacks),
      :name => name + 1
    } end), &(&1[:calories]), &>=/2)
  end

  def part1(_args) do
    elves = get_elves()
    [%{calories: calories} | _others] = rank_elves(elves)
    calories
  end

  def part2(_args) do
    elves = get_elves()
    Enum.sum(Enum.map(Enum.take(rank_elves(elves), 3), &(&1.calories)))
  end

end

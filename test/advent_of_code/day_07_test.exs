defmodule AdventOfCode.Day07Test do
  use ExUnit.Case

  import AdventOfCode.Day07

  test "part1" do
    input = AdventOfCode.Input.get!(7, 2022)
    result = part1(input)

    assert result == 1915606
  end

  @tag :skip
  test "part2" do
    input = nil
    result = part2(input)

    assert result == 5025657
  end
end

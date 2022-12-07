defmodule AdventOfCode.Day06Test do
  use ExUnit.Case

  import AdventOfCode.Day06

  test "part1" do
    input = AdventOfCode.Input.get!(6, 2022)
    result = part1(input)

    assert result = 1794
  end

  test "part2" do
    input = AdventOfCode.Input.get!(6, 2022)
    result = part2(input)

    assert result = 2851
  end
end

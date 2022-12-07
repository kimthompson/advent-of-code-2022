defmodule AdventOfCode.Day05Test do
  use ExUnit.Case

  import AdventOfCode.Day05

  test "part1" do
    input = AdventOfCode.Input.get!(5, 2022)
    result = part1(input)

    assert result == "ZWHVFWQWW"
  end

  test "part2" do
    input = AdventOfCode.Input.get!(5, 2022)
    result = part2(input)

    assert result == "HZFZCCWWV"
  end
end

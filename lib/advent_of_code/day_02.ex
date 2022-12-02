defmodule AdventOfCode.Day02 do

  @data AdventOfCode.Input.get!(2, 2022)
    |> String.split("\n", trim: true)

  @rules [
    %{name: :rock, beats: :scissors, loses: :paper, them: "A", us: "X", score: 1 },
    %{name: :paper, beats: :rock, loses: :scissors, them: "B", us: "Y", score: 2 },
    %{name: :scissors, beats: :paper, loses: :rock, them: "C", us: "Z", score: 3 }
  ]

  def victory_points(their_play, our_play) do
    case Integer.mod(their_play.score - our_play.score, 3) do
      0 -> 3
      1 -> 0
      _ -> 6
    end
  end

  def calculate_rps_score(d) do
    [them, us | _] = d
    |> String.split(" ", trim: true)

    their_play = Enum.find(@rules, &(&1.them == them))
    our_play = Enum.find(@rules, &(&1.us == us))

    our_play.score + victory_points(their_play, our_play)
  end

  def calculate_wld_score(d) do
    [them, us | _] = d
    |> String.split(" ", trim: true)

    their_play = Enum.find(@rules, &(&1.them == them))
    our_play = case us do
      "X" -> Enum.find(@rules, &(&1.name == their_play.beats))
      "Y" -> Enum.find(@rules, &(&1.name == their_play.name))
      "Z" -> Enum.find(@rules, &(&1.name == their_play.loses))
    end

    our_play.score + victory_points(their_play, our_play)
  end


  def part1(_args) do
    Enum.reduce(@data, 0, fn (match, score) ->
      score + calculate_rps_score(match)
    end)
  end


  def part2(_args) do
    Enum.reduce(@data, 0, fn (match, score) ->
      score + calculate_wld_score(match)
    end)
  end
end

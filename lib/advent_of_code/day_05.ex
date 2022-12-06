defmodule AdventOfCode.Day05 do
  @data AdventOfCode.Input.get!(5, 2022)
  # @data "    [D]    \n[N] [C]     \n[Z] [M] [P] \n1   2   3\n\nmove 1 from 2 to 1\nmove 3 from 1 to 3\nmove 2 from 2 to 1\nmove 1 from 1 to 2"
    |> String.split("\n", trim: true)

  def transpose(rows) do
    rows
    |> List.zip
    |> Enum.map(&Tuple.to_list/1)
  end

  def crate_mover_9000(instruction, stacks) do
    from = Enum.at(stacks, instruction.from - 1)
    to = Enum.at(stacks, instruction.to - 1)

    moving = List.pop_at(from, 0)
    crate = moving |> elem(0)

    stacks
    |> List.replace_at(instruction.from - 1, moving |> elem(1))
    |> List.replace_at(instruction.to - 1, List.insert_at(to, 0, crate))
  end

  def crate_mover_9001(instruction, stacks) do
    from = Enum.at(stacks, instruction.from - 1)
    to = Enum.at(stacks, instruction.to - 1)

    moving = Enum.take(from, instruction.amount)
    new_from = Enum.drop(from, instruction.amount)
    new_to = Enum.concat(moving, to)

    stacks
    |> List.replace_at(instruction.from - 1, new_from)
    |> List.replace_at(instruction.to - 1, new_to)
  end

  def to_crates(stacks) do
    Enum.reduce(stacks, [], fn x, acc ->
      result = x
      |> String.codepoints
      |> Enum.chunk_every(4)
      |> Enum.map(&Enum.join/1)
      |> Enum.map(&String.replace(&1, ~r"[\[\] ]", ""))

      acc ++ [result]
    end)
    |> Enum.reverse() |> tl() |> Enum.reverse()
    |> transpose()
    |> Enum.map(fn stack -> Enum.filter(stack, &(&1 != "")) end)
  end

  def part1(_args) do
    %{true: initial_instructions, false: initial_stacks} = @data
    |> Enum.group_by(&(&1 =~ "move"))

    # Turn these "stacks of crates" into actual Elixir Lists, flip 'em
    stacks = to_crates(initial_stacks)

    # Transform these instructions into computer-readable maps, one for each time a crate will have to be moved
    instructions = Enum.reduce(initial_instructions, [], fn x, acc ->
      move = x
        |> String.split(" ", trim: true)
        |> Enum.filter(&(&1 =~ ~r"[^a-z]"))
        |> Enum.map(&String.to_integer(&1))

      times = Enum.at(move, 0)

      result = Enum.map(1..times, fn _y ->
        %{from: Enum.at(move, 1), to: Enum.at(move, 2)}
      end)

      acc ++ [result]
    end)
    |> List.flatten()

    # Run each of these instructions on our crates
    result = Enum.reduce(instructions, stacks, fn instruction, acc ->
      acc = crate_mover_9000(instruction, acc)
    end)

    # Put the top element of each stack into a string for our answer
    Enum.reduce(result, "", fn x, acc ->
      acc <> List.first(x)
    end)
  end

  def part2(_args) do
    %{true: initial_instructions, false: initial_stacks} = @data
    |> Enum.group_by(&(&1 =~ "move"))

    # Turn these "stacks of crates" into actual Elixir Lists, flip 'em
    stacks = to_crates(initial_stacks)

    # Transform these instructions into computer-readable maps, one for each time a crate will have to be moved
    instructions = Enum.reduce(initial_instructions, [], fn x, acc ->
      move = x
        |> String.split(" ", trim: true)
        |> Enum.filter(&(&1 =~ ~r"[^a-z]"))
        |> Enum.map(&String.to_integer(&1))

      acc ++ [%{amount: Enum.at(move, 0), from: Enum.at(move, 1), to: Enum.at(move, 2)}]
    end)
    |> List.flatten()

    # Run each of these instructions on our crates
    result = Enum.reduce(instructions, stacks, fn instruction, acc ->
      acc = crate_mover_9001(instruction, acc)
    end)

    # Put the top element of each stack into a string for our answer
    Enum.reduce(result, "", fn x, acc ->
      acc <> List.first(x)
    end)
  end
end

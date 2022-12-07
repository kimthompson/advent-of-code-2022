defmodule AdventOfCode.Day07 do
  @data AdventOfCode.Input.get!(7, 2022)
  |> String.trim()
  |> String.split("\n")

  # I hit the limits of my skill here, and wanted to look up how someone else did it and attempt to understand their solution before moving on for today. I learned a lot from this code written by intercaetera, so huge shoutout to him! Here's hoping that by the end of this AoC writing recursive functions in this way will be second nature to me. https://github.com/intercaetera/aoc2022/blob/master/lib/seven.ex

  def parse_command([], tree, _), do: tree
  def parse_command([head | tail], tree, pwd) do
    case head do
      "$ cd /" -> parse_command(tail, tree, ["/"])
      "$ cd .." -> parse_command(tail, tree, tl(pwd))
      "$ cd " <> dir -> parse_command(tail, tree, [dir | pwd])
      "$ ls" -> parse_ls(tail, tree, pwd)
    end
  end

  def parse_ls([], tree, pwd), do: parse_command([], tree, pwd)
  def parse_ls([head | tail], tree, pwd) do
    case head do
      "$" <> _ -> parse_command([head | tail], tree, pwd)
      "dir " <> _dir -> parse_ls(tail, tree, pwd)
      size_and_name ->
        [size, filename] = String.split(size_and_name, " ")
        tuple = {filename, String.to_integer(size)}
        new_tree = tree |> Map.update(pwd, [tuple], fn existing -> [tuple | existing] end)
        parse_ls(tail, new_tree, pwd)
    end
  end

  def flatten_tree(tree, flat \\ %{})
  def flatten_tree([], flat), do: flat
  def flatten_tree([head | tail], flat) do
    {path, files} = head
    total_size = files |> Enum.map(fn {_, size} -> size end) |> Enum.sum()
    new_flat = groups(path) |> Enum.reduce(flat, fn path, flat ->
      Map.update(flat, path, total_size, &(&1 + total_size))
    end)
    flatten_tree(tail, new_flat)
  end

  def groups([one]), do: [[one]]
  def groups([_head | tail] = list), do: [list | groups(tail)]

  def part1(_args) do
    tree = @data
    |> parse_command(%{}, [])
    |> Map.to_list()
    |> flatten_tree()

    tree
    |> Enum.map(&(elem(&1, 1)))
    |> Enum.reject(&(&1 >= 100000))
    |> Enum.sum()
  end

  def part2(_args) do
    tree = @data
    |> parse_command(%{}, [])
    |> Map.to_list()
    |> flatten_tree()

    space_used = Map.get(tree, ["/"])
    disk_space_available = 70000000
    update_size = 30000000
    free_space = disk_space_available - space_used
    needed_space = update_size - free_space

    tree
    |> Enum.map(&(elem(&1, 1)))
    |> Enum.filter(&(&1 > needed_space))
    |> Enum.sort()
    |> hd()
  end
end

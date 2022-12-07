defmodule AdventOfCode.Day07 do
  @data AdventOfCode.Input.get!(7, 2022)
  # @data "$ cd /\n$ ls\ndir a\n14848514 b.txt\n8504156 c.dat\ndir d\n$ cd a\n$ ls\ndir e\n29116 f\n2557 g\n62596 h.lst\n$ cd e\n$ ls\n584 i\n$ cd ..\n$ cd ..\n$ cd d\n$ ls\n4060174 j\n8033020 d.log\n5626152 d.ext\n7214296 k"
    |> String.split("\n")

  def part1(_args) do
    groups = @data
    |> Enum.chunk_by(&(&1 =~ "$"))

    directives = groups
    |> Enum.take_every(2)

    contents = groups
    |> Enum.drop(1)
    |> Enum.take_every(2)

    pairs = Enum.zip(directives, contents)

    tree_nodes = pairs
    |> Enum.reduce([], fn x, acc ->
      dirname = elem(x, 0)
      |> Enum.filter(&(&1 =~ "cd"))
      |> List.last()
      |> String.split()
      |> List.last()

      files = elem(x, 1)
      |> Enum.filter(&(&1 =~ ~r{\A\d}))

      dirs = elem(x, 1)
      |> Enum.filter(&(&1 =~ "dir"))
      |> Enum.map(&String.split(&1))
      |> Enum.map(&List.last(&1))

      local_bytes = files
      |> Enum.map(&String.split(&1))
      |> Enum.map(&List.first(&1))
      |> Enum.map(&String.to_integer(&1))
      |> Enum.sum()

      acc ++ [%{dirname: dirname, files: files, dirs: dirs, local_bytes: local_bytes}]
    end)

    # For each element in dirs, look up matching dirname and sum those bytes as well
    result = tree_nodes
    |> Enum.reduce([], fn x, acc ->
      subdirs = Enum.map(x.dirs, fn y ->
        Enum.find(tree_nodes, &(&1.dirname == y)).local_bytes
      end)
      subdir_bytes = Enum.sum(subdirs)
      # acc ++ [%{dirname: x.dirname, files: x.files, dirs: x.dirs, local_bytes: x.local_bytes, subdir_bytes: subdir_bytes, total_bytes: x.local_bytes + subdir_bytes}]
      acc ++ [%{dirname: x.dirname, files: x.files, dirs: x.dirs, total_bytes: x.local_bytes + subdir_bytes}]
    end)

    # Enum.find(result, fn x -> x.dirname == "zfhnw" end)
    # Enum.find(result, fn x -> x.dirname == "pjqwq" end)
    # files: ["50937 dtzw", "186171 mjm.dhc", "305433 mlm", "272969 mlm.rhf"],

    result
    |> Enum.filter(&(&1.total_bytes < 100000))
    |> Enum.map(&(&1.total_bytes))
    |> Enum.sum
  end

  def part2(_args) do
  end
end

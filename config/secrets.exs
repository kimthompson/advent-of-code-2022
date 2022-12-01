import Config

config :advent_of_code, AdventOfCode.Input,
  allow_network?: true,
  session_cookie: System.get_env("cookie")

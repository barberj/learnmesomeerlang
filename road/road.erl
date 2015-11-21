-module(road).
-export([cli/1, main/0]).

main() ->
  main("road.txt").

main(Filename) ->
  Tokens = tokens_from_file(Filename),
  Tuples = group_into_tuples(Tokens, []),
  optimal_path(Tuples).

% erl -noshell -run road cli road.txt
cli(Filename) ->
  io:format("~p~n",[main(Filename)]),
  erlang:halt(0).

tokens_from_file(Filename) ->
  {ok, Binary} = file:read_file(Filename),
  [list_to_integer(X) || X <- string:tokens(binary_to_list(Binary), "\r\n\t ")].

group_into_tuples([], Tuples)           -> Tuples;
group_into_tuples([A, B, X| T], Tuples) ->
  group_into_tuples(T, Tuples ++ [{A, B, X}]).

optimal_path(Map) ->
  {A,B} = lists:foldl(fun shortest_step/2, {{0,[]}, {0,[]}}, Map),
  {_Dist,Path} = erlang:min(A, B),
  Path.

shortest_step({A,B,X}, {{DistA,PathA}, {DistB,PathB}}) ->
  OptA1 = {DistA + A, PathA ++ [{a,A}]},
  OptA2 = {DistB + B + X, PathB ++ [{b,B}, {x,X}]},
  OptB1 = {DistB + B, PathB ++ [{b,B}]},
  OptB2 = {DistA + A + X, PathA ++ [{a,A}, {x,X}]},
  {erlang:min(OptA1, OptA2), erlang:min(OptB1, OptB2)}.


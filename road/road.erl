-module(road).
-export([main/0]).

main() ->
  Tokens = tokens_from_file(),
  Tuples = group_into_tuples(Tokens, []),
  optimal_path(Tuples).

tokens_from_file() ->
  {ok, Binary} = file:read_file("road.txt"),
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


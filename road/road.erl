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
  {_Dist,Path} = if
    hd(element(2,A)) =/= {x,0} -> A;
    hd(element(2,B)) =/= {x,0} -> B
   end,
  lists:reverse(Path).

shortest_step({A,B,X}, {{DistA,PathA}, {DistB,PathB}}) ->
  OptA1 = {DistA + A, [{a,A}|PathA]},
  OptA2 = {DistB + B + X, [{x,X}, {b,B}|PathB]},
  OptB1 = {DistB + B, [{b,B}|PathB]},
  OptB2 = {DistA + A + X, [{x,X}, {a,A}|PathA]},
  {erlang:min(OptA1, OptA2), erlang:min(OptB1, OptB2)}.


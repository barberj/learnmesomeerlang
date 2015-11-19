-module(calc).
-export([rpn/1]).

rpn(Expression) when is_list(Expression) ->
  [Res] = lists:foldl(fun rpn/2, [], string:tokens(Expression, " ")),
  Res.

rpn("+", [N1,N2|S]) -> [N2+N1|S];
rpn("*", [N1,N2|S]) -> [N2*N1|S];
rpn("-", [N1,N2|S]) -> [N2-N1|S];
rpn("/", [N1,N2|S]) -> [N2/N1|S];
rpn("^", [N1,N2|S]) -> [math:pow(N2,N1)|S];
rpn("ln", [N|S])    -> [math:log(N)|S];
rpn("log10", [N|S]) -> [math:log10(N)|S];
rpn("sum", S) -> [lists:foldl(fun(X, Sum) -> X + Sum end, 0, S)];
rpn("prod", S) -> [lists:foldl(fun(X, Sum) -> X * Sum end, 1, S)];
rpn(Op,Stack) -> [read(Op)|Stack].

read(N) ->
  case string:to_float(N) of
    {error,no_float} -> list_to_integer(N);
    {F,_} -> F
  end.

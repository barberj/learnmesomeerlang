% To run tests:
% erl -make
% erl -noshell -eval "eunit:test(calc, [verbose])" -s init stop
%

-module(calc_tests).
-include_lib("eunit/include/eunit.hrl").

addition_test() ->
  ?assertEqual(4, calc:rpn("2 2 +")),
  ?assertEqual(5, calc:rpn("2 3 +")).

subtraction_test() ->
  ?assertEqual(87, calc:rpn("90 3 -")),
  ?assertEqual(0, calc:rpn("2 2 -")).

multiplication_test() ->
  ?assertEqual(6, calc:rpn("2 3 *")).

division_test() ->
  ?assert(2 == calc:rpn("6 3 /")).

power_test() ->
  ?assert(8 == calc:rpn("2 3 ^")),
  ?assert(math:sqrt(2) == calc:rpn("2 0.5 ^")).

log_test() ->
  ?assert(math:log(2.7) == calc:rpn("2.7 ln")),
  ?assert(math:log10(2.7) == calc:rpn("2.7 log10")).

sum_test() ->
  ?assert(50 == calc:rpn("10 10 10 20 sum")).

prod_test() ->
  ?assert(1000 == calc:rpn("10 10 20 0.5 prod")).

combintation_test() ->
  ?assertEqual(-4, calc:rpn("10 4 3 + 2 * -")),
  ?assertEqual(-2.0, calc:rpn("10 4 3 + 2 * - 2 /")),
  ?assertEqual(4037, calc:rpn("90 34 12 33 55 66 + * - + -")),
  ?assert(10 == calc:rpn("10 10 10 20 sum 5 /")).

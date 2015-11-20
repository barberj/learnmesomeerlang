% To run tests:
% erl -make
% erl -noshell -eval "eunit:test(road, [verbose])" -s init stop
%

-module(road_tests).
-include_lib("eunit/include/eunit.hrl").

path_test() ->
  ?assertEqual([{b,10},{x,30},{a,5},{x,20},{b,2},{b,8}], road:main()).

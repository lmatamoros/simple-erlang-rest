-module(simple_erlang_rest_home).

-export([init/2,
        terminate/3,
        handle/2,
        allowed_methods/2,
        content_types_provided/2,
        handle_get/2]).

init(Req, Opts) ->
  {cowboy_rest, Req, Opts}.

handle(Req, State) -> {ok, Req, State}.

terminate(_Reason, _Req, _State) -> ok.

allowed_methods(Req, State) -> {[<<"GET">>], Req, State}.

content_types_provided(Req, State) ->
  {[
    {{<<"application">>,<<"json">>, []}, handle_get}
  ], Req, State}.

handle_get(Req, State) ->
  simple_erlang_rest_utils:serviceResponse(<<"home">>, 200, Req, State).
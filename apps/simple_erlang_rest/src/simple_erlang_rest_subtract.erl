-module(simple_erlang_rest_subtract).

-export([init/2,
        terminate/3,
        handle/2,
        allowed_methods/2,
        content_types_accepted/2,
        handle_post/2]).

-define(REQUIRE_FIELDS, [<<"left">>, <<"right">>]).

init(Req, Opts) ->
    {cowboy_rest, Req, Opts}.

handle(Req, State) -> {ok, Req, State}.

terminate(_Reason, _Req, _State) -> ok.

allowed_methods(Req, State) -> {[<<"POST">>], Req, State}.

content_types_accepted(Req, State) ->
    {[
        {{<<"application">>, <<"json">>, []}, handle_post}
    ], Req, State}.

handle_post(Req, State) ->
    {Req2, Body} = simple_erlang_rest_utils:decode_request(Req),
    NotFoundFields = simple_erlang_rest_utils:checkSchema(?REQUIRE_FIELDS, Body, []),
    execute(NotFoundFields, Body, Req2, State).

execute([], Body, Req, State) -> 
    {<<"left">>, Left} = lists:keyfind(<<"left">>, 1, Body),
    {<<"right">>, Right} = lists:keyfind(<<"right">>, 1, Body),
    Result = Left - Right,
    simple_erlang_rest_utils:serviceResponse(Result, 200, Req, State);
execute(NotFoundFields, _, Req, State) -> 
    simple_erlang_rest_utils:serviceResponse(NotFoundFields, 400, Req, State).

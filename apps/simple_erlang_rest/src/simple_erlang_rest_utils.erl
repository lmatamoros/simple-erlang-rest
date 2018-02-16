-module(simple_erlang_rest_utils).

-export([
    checkSchema/3,
    serviceResponse/4,
    decode_request/1
]).

checkSchema([], _, NotFound) -> NotFound;
checkSchema([Field|Fields], Data, NotFound) -> 
    NNotFound = checkField((catch lists:keyfind(Field, 1, Data)), Field, NotFound),
    checkSchema(Fields, Data, NNotFound).

checkField(false, Field, NotFound) -> [Field|NotFound];
checkField({'EXIT',{badarg, _}}, Field, NotFound) -> [Field|NotFound];
checkField(_, _, NotFound) -> NotFound.

serviceResponse(Result, 200, Req, State) -> 
    Body = jsx:encode([{<<"status">>,200}, {<<"result">>,Result}]),
    {ok, cowboy_req:reply(200, [ {<<"content-type">>, <<"application/json">>} ], Body, Req), State};
serviceResponse(Error, Code, Req, State) -> 
    Body = jsx:encode([{<<"status">>,Code}, {<<"error">>,Error}]),
    {ok, cowboy_req:reply(Code, [ {<<"content-type">>, <<"application/json">>} ], Body, Req), State}.

decode_request(Req) -> 
    {ok, Json, Req2} = cowboy_req:body(Req),
    {Req2, jsx:decode(Json)}.

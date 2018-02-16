-module(simple_erlang_rest_app).

-behaviour(application).

-define(APPS, [inets, ranch, crypto, cowlib, cowboy, jsx]).
-define(LPort, (case os:getenv("SIMPLE_REST_PORT") of 
	false -> element(2, application:get_env(simple_erlang_rest, port)); 
	Port -> Port end)).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    init_apps(?APPS),
	Dispatch = cowboy_router:compile([
		{'_', [
			{"/simple_erlang_rest", simple_erlang_rest_home, []},
			{"/simple_erlang_rest/add", simple_erlang_rest_add, []},
			{"/simple_erlang_rest/subtract", simple_erlang_rest_subtract, []},
			{"/simple_erlang_rest/multiply", simple_erlang_rest_multiply, []},
			{"/simple_erlang_rest/divide", simple_erlang_rest_divide, []},
			{'_', simple_erlang_rest_not_found, []}
		]}
	]),
	{ok, _} = cowboy:start_http(http_listener, 100,
		[{port, ?LPort}],
		[{env, [{dispatch, Dispatch}]}]
	),
    simple_erlang_rest_sup:start_link().

stop(_State) ->
    ok.

init_apps([]) -> ok;
init_apps([App | Apps]) ->
    case application:start(App) of
        ok -> init_apps(Apps);
        {error, {already_started, App}} -> init_apps(Apps)
    end.

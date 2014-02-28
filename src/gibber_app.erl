%% @private
-module(gibber_app).
-behavior(application).

%% API
-export([start/2]).
-export([stop/1]).

-define(PORT, 8080).

%% API
start(_Type, _Args) ->
    Dispatch = cowboy_router:compile([
        {'_', [
            {"/", cowboy_static, {priv_file, gibber, "index.html"}},
            {"/websocket", gibber_handler, []},
            {"/static/[...]", cowboy_static, {priv_dir, gibber, "static"}}
        ]}
    ]),
    {ok, _} = cowboy:start_http(http, 100, [{port, ?PORT}],
        [{env, [{dispatch, Dispatch}]}]),
    gibber_sup:start_link().

stop(_State) ->
    ok.

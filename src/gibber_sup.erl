%% @private
-module(gibber_sup).
-behavior(supervisor).

%% API
-export([start_link/0]).

%% supervisor
-export([init/1]).

-define(SERVER, ?MODULE).

%% API
-spec start_link() -> {ok, pid()}.
start_link() ->
    supervisor:start_link({local, ?SERVER}, ?MODULE, []).

%% supervisor
init([]) ->
    Procs = [],
    {ok, {one_for_one, 10, 10}, Procs}.

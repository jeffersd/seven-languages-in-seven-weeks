-module(doctor_sup2).
-behavior(supervisor).
-export([start_link/0, init/1]).

start_link() ->
    io:format("Creating doctor supervisor supervisor.~n"),
    supervisor:start_link(doctor_sup2, []).

init(_Args) ->
    SupFlags = #{strategy => one_for_one, intensity => 1, period => 5},
    ChildSpecs = [#{id => doctor_sup,
                    start => {doctor_sup, start_link, []},
                    restart => permanent,
                    shutdown => brutal_kill,
                    type => supervisor,
                    modules => [doctor_sup]}],
    {ok, {SupFlags, ChildSpecs}}.

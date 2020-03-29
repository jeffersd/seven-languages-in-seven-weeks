-module(doctor_sup).
-behavior(supervisor).
-export([start_link/0, init/1]).

start_link() ->
    supervisor:start_link(doctor_sup, []).

init(_Args) ->
    SupFlags = #{strategy => one_for_one, intensity => 1, period => 5},
    ChildSpecs = [#{id => doctor,
                    start => {doctor, sup_start, []},
                    restart => permanent,
                    shutdown => brutal_kill,
                    type => worker,
                    modules => [doctor]}],
    {ok, {SupFlags, ChildSpecs}}.

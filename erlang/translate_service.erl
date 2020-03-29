-module(translate_service).
-export([loop/0, translate/2]).
-export([start/0, kill/1]).
loop() ->
    receive
        exit ->
            exit({translate_service,die,at,erlang:time()});

        {From, "casa"} ->
            From ! "house",
            loop();

        {From, "blanca"} ->
            From ! "white",
            loop();

        {From, _} ->
            From ! "I don't understand.",
            loop()
end.

translate(To, Word) ->
    To ! {self(), Word},
    receive
        Translation -> Translation
end.

kill(Pid) ->
    Pid ! exit.

start() ->
    Pid = spawn_link(fun loop/0),
    register(translator, Pid),
    {ok, Pid}.

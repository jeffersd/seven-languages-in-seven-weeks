-module(translate_service).
-export([loop/0, translate/1]).
-export([start/0, kill/0]).
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

translate(Word) ->
    translate_service ! {self(), Word},
    receive
        Translation -> Translation
end.

kill() ->
    translate_service ! exit.

start() ->
    Pid = spawn_link(fun loop/0),
    register(translate_service, Pid),
    {ok, Pid}.

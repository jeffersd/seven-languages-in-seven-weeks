-module(monitor).
-export([loop/0, monitor/1]).
create_gun() ->
    Pid = spawn(fun roulette:loop/0),
    register(gun, Pid),
    monitor(process, Pid).

loop() ->
    receive
        {'DOWN', Ref, Type, Object, Info} ->
            io:format("our process is down ~p - ~p - ~p - ~p ~n", [Ref, Type, Object, Info]),
            io:format("recreating..~n"),
            create_gun(),
            loop();
        create ->
            io:format("creating gun..~n"),
            create_gun();
        _ ->
            io:format("message not understood~n"),
            loop()
    end.
monitor(Pid) ->
    monitor(process, Pid),
    loop().

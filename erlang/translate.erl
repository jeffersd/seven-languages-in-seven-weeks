-module(translate).
-export([loop_async/0, loop_sync/0]).
loop_async() ->
    receive
        "casa" ->
            io:format("house~n"),
            loop_async();
        "blanca" ->
            io:format("white~n"),
            loop_async();
        _ ->
            io:format("I don't understand.~n"),
            loop_async()
    end.

loop_sync() ->
    receive
        {Pid, "casa"} ->
            Pid ! "house",
            loop_sync();
        {Pid, "blanca"} ->
            Pid ! "white",
            loop_sync();
        {Pid, _} ->
            Pid ! "I don't understand.",
            loop_sync()
    end.

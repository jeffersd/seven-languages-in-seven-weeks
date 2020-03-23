-module(translate).
-export([loop/0]).
loop() ->
    receive
        {Pid, "casa"} ->
            Pid ! "house",
            loop();
        {Pid, "blanca"} ->
            Pid ! "white",
            loop();
        {Pid, _} ->
            Pid ! "I don't understand.",
            loop()
end.

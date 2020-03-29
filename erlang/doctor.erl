-module(doctor).
-export([loop/0]).
-export([sup_start/0]).
loop() ->
    process_flag(trap_exit, true),
    receive
        new ->
            io:format("Creating and monitoring process.~n"),
            register(revolver, spawn_link(fun roulette:loop/0)),
            loop();
        hello ->
            io:format("Hello.~n"),
            loop();
        exit ->
            exit({doctor,die,at,erlang:time()});
        {'EXIT', From, Reason} ->
            io:format("The shooter ~p died with reason ~p.", [From, Reason]),
            io:format("Restarting. ~n"),
            self() ! new,
            loop()
    end.

sup_start() ->
    Pid = spawn_link(fun loop/0),
    register(doctor, Pid),
    {ok, Pid}.

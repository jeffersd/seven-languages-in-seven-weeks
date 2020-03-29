-module(doctor).
-export([loop/0]).
-export([sup_start/0]).
loop() ->
    process_flag(trap_exit, true),
    RevolverPid = whereis(revolver),
    receive
        new ->
            io:format("Creating and monitoring process: revolver.~n"),
            register(revolver, spawn_link(fun roulette:loop/0)),
            loop();
        hello ->
            io:format("Hello.~n"),
            loop();
        {'EXIT', RevolverPid, Reason} ->
            io:format("The shooter ~p died with reason ~p. ", [RevolverPid, Reason]),
            io:format("Restarting. ~n"),
            self() ! new,
            loop()
    end.

sup_start() ->
    Pid = spawn_link(fun loop/0),
    register(doctor, Pid),
    {ok, Pid}.

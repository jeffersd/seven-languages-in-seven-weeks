-module(doctor_mon).
-export([loop/0]).
-export([sup_start/0]).

loop() ->
    process_flag(trap_exit, true),
    DoctorPid = whereis(doctor),
    receive
        new ->
            io:format("Creating and monitoring process: doctor.~n"),
            register(doctor, spawn_link(fun doctor:loop/0)),
            loop();
        hello ->
            io:format("Hello.~n"),
            loop();
        {'EXIT', DoctorPid, Reason} ->
            io:format("The doctor ~p died with reason ~p. ", [DoctorPid, Reason]),
            io:format("Restarting.~n"),
            self() ! new,
            loop()
    end.

sup_start() ->
    io:format("Supervisor created process: doctor_mon.~n"),
    Pid = spawn_link(fun loop/0),
    register(doctor_mon, Pid),
    {ok, Pid}.

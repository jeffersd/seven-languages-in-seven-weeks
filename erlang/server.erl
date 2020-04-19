-module(server).
-export([start/0, stop/0, message/1, loop/0]).

start() ->
    register(server, spawn(server, loop, [])).

stop() ->
    exit(whereis(server), kill).

message(Message) ->
    server ! Message.

log(Message) ->
    {ok, File} = file:open("./server.log", [append]),
    file:write(File, Message),
    file:write(File, "\n"),
    file:close(File).

loop() ->
    receive
        Message ->
            log(Message),
            loop()
    end.

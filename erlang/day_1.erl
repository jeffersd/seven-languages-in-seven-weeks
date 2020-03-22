-module(day_1).
-export([count_words/1]).
-export([count_to_ten/1]).
-export([print_message/1]).

% Write a function that uses recursion to return the number of words in a string.
count_words("") -> 0;
count_words([ 32 | [] ]) -> 0;
count_words([ _ | [] ]) -> 1;
count_words([ 32, 32 | Tail ]) -> count_words(Tail);
count_words([ _, 32 | Tail ]) -> 1 + count_words(Tail);
count_words([ _ | Tail ]) -> count_words(Tail).

% Write a function that uses recursion to count to ten.
count_to_ten(10) -> io:format("10\n");
count_to_ten(N) -> io:format("~b\n", [N]), count_to_ten(N + 1).

% Write a function that uses matching to selectively print "success" or "error: message" given input of the form {error: Message} or success.
print_message(success) -> io:format("success\n");
print_message({error, Message}) -> io:format("error: ~s\n", [Message]).

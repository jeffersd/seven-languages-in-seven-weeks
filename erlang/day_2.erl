-module(day_2).
-export([get_value/2]).
-export([grocery_bill/1]).
-export([tic_tac_toe/1]).

% sample board test functions for tic tac toe
-export([get_board/0]).
-export([get_board1/0]).
-export([get_board2/0]).
-export([get_board3/0]).
-export([get_board4/0]).

% Consider a list of keyword-value tuples, such as [{erlang, "a functional language"}, {ruby, "an OO language"}].
% Write a function that accepts the list and a keyword and returns the associated value for the keyword.
get_value([], _) -> none;
get_value([{Keyword, Value} | _], Keyword) -> Value;
get_value([_ | Tail], Keyword) -> get_value(Tail, Keyword).


% Consider a shopping list that looks like [{item quantity price}, ...].
% Write a list comprehension that builds a list of items of the form [{item total_price}, ...], where total_price is quantity times price.
grocery_bill(ShoppingList) -> [{Item, Quantity * Price} || {Item, Quantity, Price} <- ShoppingList].


% Bonus problem:
% Write a program that reads a tic-tac-toe board presented as a list or a tuple of size nine.
% Return the winner (X or O) if a winner has been determined, cat if there are no possible moves, or no_winner if no player has won yet.

% validates that we matched an x or an o
check_character(false) -> false;
check_character(x) -> x;
check_character(o) -> o;
check_character(_) -> false.

% three adjacent is a row
check_rows([A, A, A, _, _, _, _, _, _]) -> A;
check_rows([_, _, _, A, A, A, _, _, _]) -> A;
check_rows([_, _, _, _, _, _, A, A, A]) -> A;
check_rows(_) -> false.

% count forward three to find a column
check_columns([A, _, _, A, _, _, A, _, _]) -> A;
check_columns([_, A, _, _, A, _, _, A, _]) -> A;
check_columns([_, _, A, _, _, A, _, _, A]) -> A;
check_columns(_) -> false.

% count foward four or two to find a diagonal
check_diagonals([A, _, _, _, A, _, _, _, A]) -> A;
check_diagonals([_, _, A, _, A, _, A, _, _]) -> A;
check_diagonals(_) -> false.

% return true if the board is full
check_no_moves_left(Board) -> lists:all(fun(X) -> not (X == " ") end, Board).

tic_tac_toe(Board) ->
  RowMatch = check_character(check_rows(Board)),
  ColumnMatch = check_character(check_columns(Board)),
  DiagonalMatch = check_character(check_diagonals(Board)),

  NoMovesLeft = check_no_moves_left(Board),
  if
    not (RowMatch == false) -> RowMatch;
    not (ColumnMatch == false) -> ColumnMatch;
    not (DiagonalMatch == false) -> DiagonalMatch;
    NoMovesLeft -> cat;
    true -> no_winner
  end.


% some test functions to return sample board objects
get_board() -> [x, x, x, o, " ", o, " ", " ", o]. % row win: x
get_board1() -> [" ", " ", " ", " ", " ", " ", " ", " ", " "]. % no_winner
get_board2() -> [x, x, o, " ", x, o, " ", " ", o]. % column win: o
get_board3() -> [x, o, x, o, x, o, x, o, o]. % diagonal win: x
get_board4() -> [x, o, x, x, o, o, o, x, o]. % cat

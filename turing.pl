% Turing machine to invert characters in the set [a, b]

% main code

run(Input, Output) :-
	recognize(Input),
	run(Input, Output, _).

run(Input, Output, State) :-
	initial(State0),
	tape_list_position(Tape0, Input, 0),
	run(State0, Tape0, State, Tape),
	tape_list_position(Tape, Output, _).

recognize(Input) :-
	run(Input, _, State),
	accepting(State).

% state transition

run(State0, Tape0, State, Tape) :-
	(   step(State0, Tape0, State1, Tape1) ->
	        run(State1, Tape1, State, Tape)
	;   State = State0,
	    Tape = Tape0
	).

step(State0, Tape0, State, Tape) :-
	replace_tape_symbol(Tape0, Sym0, Tape1, Sym1),
	delta(State0, Sym0, State, Sym1, Direction),
	move_tape(Direction, Tape1, Tape).

% handling the tape

tape_list_position(tape(Left,Right), List, Pos) :-
	length(Left, Pos),
	reverse(Left, Left1),
	append(Left1, Right, List).

replace_tape_symbol(tape(Left0,Right0), Sym0, tape(Left0,Right), Sym) :-
	replace_next_of_infinite_tape(Right0, Sym0, Right, Sym).

move_tape(left,  tape([Lsym|Left],Right), tape(Left,[Lsym|Right])).
move_tape(right, tape(Left,Right), tape([Rsym|Left],Right1)) :-
	replace_next_of_infinite_tape(Right, Rsym, [_|Right1], Rsym).

replace_next_of_infinite_tape([Sym0|Rest], Sym0, [Sym|Rest], Sym).
replace_next_of_infinite_tape([], 'B', [Sym], Sym).

% Turing machine

delta(q0, 'B', q1, 'B', right).
delta(q1, 'B', q2, 'B', left).
delta(q1, a, q1, b, right).
delta(q1, b, q1, a, right).
delta(q2, a, q2, a, left).
delta(q2, b, q2, b, left).

initial(q0).
accepting(q2).

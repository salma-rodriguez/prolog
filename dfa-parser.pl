parse(L) :-
	start(S),
	trans(S,L).

% works for dfa

trans(X,[A|B]) :-
	delta(X,A,Y),
	write(X),
	write('  '),
	write([A|B]),
	nl,
	trans(Y,B).
trans(X,[]) :-
	final(X),
	write(X),
	write('  '),
	write([]),
	nl.

% dfa machine

delta(0,a,1).
delta(0,b,0).
delta(1,a,1).
delta(1,b,2).
delta(2,a,2).
delta(2,b,2).

start(0).
final(2).

% sample query: ?- parse([b,b,b,a,a,b,a,a,b,a]).

% works for nfa

parse(L) :-
	start(S),
	trans(S,L).

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
trans(X,L) :-
	lamda(X,Y),
	trans(Y,L).

% nfa machine

delta(p,a,p).
delta(p,b,p).
delta(p,b,q).

lamda(q, p).

start(p).
final(q).

% sample query: ?- parse([a,a,b,b,b,b]).



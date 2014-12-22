% basic	list definitions

car([X|_],X).
cdr([_|Y],Y).
cons(X,R,[X|R]).

member(X,[X|_]).
member(X,[_|R]) :- member(X,R).

takeout(X,[X|R],R).
takeout(X,[H|R],[H|S]) :- takeout(X,R,S).

putin(X,L,R) :- takeout(X,R,L).

append([X|Y],Z,[X|W]) :- append(Y,Z,W).
append([],X,X).

% efficient way to reverse a list

reverse([X|Y],Z,W) :- reverse(Y,[X|Z],W).
reverse([],X,X).

reverse(A,R) :- reverse(A,[],R).

% not very efficient: twice the number of calls

mreverse([X|R],T) :- mreverse(R,S), append(S,[X],T).
mreverse([],[]).

perm([X|Y],Z) :- perm(Y,W), takeout(X,Z,W).
perm([],[]).

subset([X|R],S) :-
	member(X,S), subset(R,S).

union([X|Y],Z,W) :- member(X,Z), union(Y,Z,W).
union([X|Y],Z,[X|W]) :- \+ member(X,Z), union(Y,Z,W).
union([],Z,Z).

intersection([X|Y],Z,[X|W]) :- member(X,Z), intersection(Y,Z,W).
intersection([X|Y],Z,W) :- \+ member(X,Z), intersection(Y,Z,W).
intersection([],_,[]).

delete(X,[X|L],L) :- !.
delete(X,[H|L],[H|R]) :- delete(X,L,R).

prune([],[]).
prune([H|A],[H|B]) :- delete(H,A,S), prune(S,B).

prefix([],_).
prefix([X|A],[X|B]) :- prefix(A,B).

segment([X|A],[X|B]) :- prefix([X|A],[X|B]).
segment([X|A],[_|B]) :- segment([X|A],B),!.
segment([],_).

% sequences

sequence_append((X,R),S,(X,T)) :-
	!,
	sequence_append(R,S,T).
sequence_append((X),S,(X,S)).

sequence_reverse((X,R),T) :-
	!,
	sequence_reverse(R,S), sequence_append(S,(X),T).
sequence_reverse((X),(X)).

sequence_member(X,(X,_)).
sequence_member(X,(_,S)) :- sequence_member(X,S).
sequence_member(X,X).

sequence_delete(X,(X,S),R) :- !,sequence_delete(X,S,R).
sequence_delete(X,(Y,S),(Y,R)) :- !,sequence_delete(X,S,R).
sequence_delete(_,Y,Y).

sequence_prune((X,S),(X,R)) :- sequence_delete(X,S,Q), !, sequence_prune(Q,R).
sequence_prune(X,X).

:- op(500,yfx,'#').        /* pound delimited sequence */

sequence_pmember(X,(X#_)).
sequence_pmember(X,(_#S)) :- sequence_pmember(X#S).
sequence_pmember(X#X).











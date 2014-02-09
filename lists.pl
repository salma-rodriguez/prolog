append([],List,List).                      % append [] to list = list

append([H|Tail],X,[H|NewTail]) :-
	append(Tail,X,NewTail).                  % if we can append Tail to X
					   % then we have NewTail

reverse([],[]).                            % reverse of empty list is empty list

reverse([H|T],R) :-
	reverse(T,T_reversed),                   % reverse the tail
        append(T_reversed,[H],R).          % append the result to the list [H]

palindrome(List) :- reverse(List, List).

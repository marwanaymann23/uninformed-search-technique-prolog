:-use_module(library(lists)).

appendFun([],List,List).
appendFun([H|T],List,[H|List2]):-
    appendFun(T,List,List2).

listSum([],0).
listSum([H|T],N):-
    listSum(T,N1),
    N is N1 + H.

firstElement([H|_],H).

deleteElement(Y,[Y],[]).
deleteElement(X,[X|List1],List1).
deleteElement(X,[Y|List],[Y|List1]):-
    deleteElement(X,List,List1),
    !.

% Start problem one uninformed search %

threeSum([A,B,C],Goal,Output):-
    Goal =:= A+B+C,
    Output = [A,B,C],!.

threeSum([H|T],Goal,Output):-
    firstElement(T,H2),
    deleteElement(H2,T,NewT),
    path(H,H2,NewT,Goal,Output)->
    threeSum(T,Goal,Output)
    ;
    threeSum(T,Goal,Output).

path(H,H2,T,Goal,Output):-
     loopOne([H,H2],T,Goal,Output) ->
         firstElement(T,H3),
         deleteElement(H3,T,NewT),
         path(H,H3,NewT,Goal,Output)
     ;
         firstElement(T,H3),
         deleteElement(H3,T,NewT),
         path(H,H3,NewT,Goal,Output).

loopOne(List,[H3|T2],Goal,Output):-
    appendFun(List,[H3],NewList),
    listSum(NewList, Result),
    Goal =:= Result ->
           Output = NewList,
           write('Output = '),
           write(Output),nl,
           loopOne(List,T2,Goal,Output)
    ;
           loopOne(List,T2,Goal,Output).

% End problem one uninformed search %



% Start problem one informed search using greedy algorithm %

problemOneHeuristic(List,Goal,Result):-
    listSum(List,Sum),
    Result is Goal-Sum.
informedThreeSum([H|T],Goal,Output):-
    problemOneHeuristic([H],Goal,Result),
    appendFun([H],[],Closed),
    appendFun(T,[],Open),
    firstElement(T,H2),
    deleteElement(H2,T,NewT),
    pathGreedy(H,H2,NewT,Open,Closed,Goal,Output).


pathGreedy(H,H2,T,Open,Closed,Goal,Output):-
    deleteElement(H2,Open,NewOpen),
    appendFun([H2],Closed,NewClosed),
    appendFun(T,NewOpen,OpenTwo).

% End problem one informed search using greedy algorithm %





% Start problem two informed search using greedy algorithm %

size([],0).
size([_|T],N):-
    size(T,N1),
    N is N1+1.


deletiveEditing([],[]).

deletiveEditing([H1|T1],[H2|T2]):-
    H1 = H2,!,
    deletiveEditing(T1,T2).


deletiveEditing([H1|T1],[H2|T2]):-
    member(H2,[H1|T1]),!,
    deletiveEditing([H1|T1],T2).

deleteFunc([H1|T1],[H2|T2] , Output ):-
 deleteFunc([H1|T1],[H2|T2] ,[H1|T1], Output ).

% % End problem two informed search using greedy algorithm %

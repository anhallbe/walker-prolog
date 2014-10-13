/* -*- Mode:Prolog; coding:iso-8859-1; -*- */
:- use_module(library(random)).
:- use_module(library(system)).
%:- use_module(library(lists)).


%Initiate random module
init :-
        use_module(library(random)).

%Reached the end (goal)
walk((Xs,Ys), (Xe,Ye), _, Walked, Length) :-
        Xs =:= Xe,
        Ys =:= Ye,
        length(Walked, Length).

%Reached end of world (or an older path)
walk(Current, _, _, _, Length) :-
        Current = blocked,
        Length is 9999999.

%Try walking in all directions
walk(Start, End, Max, Walked, Length) :-
        possible_steps(Start, Max, Walked, (Right, Left, Up, Down)),
        walk(Right, End, Max, [Start|Walked], LR),
        walk(Left, End, Max, [Start|Walked], LL),
        walk(Down, End, Max, [Start|Walked], LD),
        walk(Up, End, Max, [Start|Walked], LU),
        Length is min(LR, min(LL, min(LU, LD))),
        print('min: '),
        print(Length),
        print('\n').

%Give a list of possible walk destinations
possible_steps((StartX, StartY), Max, Walked, Walks) :-
        Xright is StartX+1,
        Xleft is StartX-1,
        Yup is StartY-1,
        Ydown is StartY+1,
        %Right?
        ((StartX < Max, \+memberchk((Xright, StartY), Walked)) -> Right = (Xright, StartY); Right = blocked),
        %Left?
        (StartX > 0, \+memberchk((Xleft, StartY), Walked) -> Left = (Xleft, StartY); Left = blocked),
        %Up?
        (StartY > 0, \+memberchk((StartX, Yup), Walked) -> Up = (StartX, Yup); Up = blocked),
        %Down?
        (StartY < Max, \+memberchk((StartX, Ydown), Walked) -> Down = (StartX, Ydown); Down = blocked),
        Walks = (Right, Left, Up, Down).
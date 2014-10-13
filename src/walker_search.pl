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

%Reached end of world
walk(Start, End, Max, Walked, Length) :-
        Start = blocked,
        Length is 9999999,
        print('(blocked) ').

%Walked to somewhere I've been before
walk(Start, End, Max, Walked, Length) :-
        member(Start, Walked),
        Length is 9999999,
        print('(already been there..) ').

%Try walking in all directions
walk(Start, End, Max, Walked, Length) :-
        %sleep(1),
        possible_steps(Start, Max, Walked, (Right, Left, Up, Down)),
        print('Right '),
        walk(Right, End, Max, [Start|Walked], LR),
        %sleep(1),
        print('Down '),
        walk(Down, End, Max, [Start|Walked], LD),
        %sleep(1),
        print('Left '),
        walk(Left, End, Max, [Start|Walked], LL),
        %sleep(1),
        print('Up '),
        walk(Up, End, Max, [Start|Walked], LU),
        %Length is min(LR, min(LL, min(LU, LD))).
        Length is min(999, min(LR, min(LL, min(LU, LD)))).
        
        %(Right \= blocked -> walk(Right, End, Max, [Start|Walked], Length); print('Right blocked!\n')),
        %(Left \= blocked -> walk(Left, End, Max, [Start|Walked], Length); print('Left blocked!\n')),
        %(Up \= blocked -> walk(Up, End, Max, [Start|Walked], Length); print('Up blocked!\n')),
        %(Down \= blocked -> walk(Down, End, Max, [Start|Walked], Length); print('Down blocked!\n')).

        %walk(Right, End, Max, [Start|Walked], SuccessRight, LengthRight),
        %walk(Left, End, Max, [Start|Walked], SuccessLeft, LengthLeft),
        %walk(Up, End, Max, [Start|Walked], SuccessUp, LengthUp),
        %walk(Down, End, Max, [Start|Walked], SuccessDown, LengthDown),
        %Success = yes,
        %Length = min(LengthRight, min(LengthLeft, min(LengthUp, LengthDown))).

%Give a list of possible walk destinations
possible_steps((StartX, StartY), Max, Walked, Walks) :-
        %Right?
        Xright is StartX+1,
        Xleft is StartX-1,
        Yup is StartY-1,
        Ydown is StartY+1,
        ((StartX < Max, \+member((Xright, StartY), Walked)) -> Right = (Xright, StartY); Right = blocked),
        %Left?
        (StartX > 0, \+member((Xleft, StartY), Walked) -> Left = (Xleft, StartY); Left = blocked),
        %Up?
        (StartY > 0, \+member((StartX, Yup), Walked) -> Up = (StartX, Yup); Up = blocked),
        %Down?
        (StartY < Max, \+member((StartX, Ydown), Walked) -> Down = (StartX, Ydown); Down = blocked),
        %print('Walks: ('),
        %print(Right),
        %print(') ('),
        %print(Left),
        %print(') ('),
        %print(Up),
        %print(') ('),
        %print(Down),
        %print(')\n'),
        Walks = (Right, Left, Up, Down).
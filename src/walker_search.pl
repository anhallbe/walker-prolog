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
        %print(' Reached goal in '),
        %print(Length),
        %print(' steps. ').

%Reached end of world (or an older path)
walk(Start, End, Max, Walked, Length) :-
        Start = blocked,
        Length is 9999999.
        %print('(blocked) ').

%Walked to somewhere I've been before
%walk(Start, End, Max, Walked, Length) :-
%        memberchk(Start, Walked),
%        Length is 9999999,
%        print('(already been there..) ').

%Try walking in all directions
walk(Start, End, Max, Walked, Length) :-
        %sleep(1),
        possible_steps(Start, Max, Walked, (Right, Left, Up, Down)),
        %print('\nRight '),
        walk(Right, End, Max, [Start|Walked], LR),
        %print(LR),
        %sleep(1),
        %print('\nLeft '),
        walk(Left, End, Max, [Start|Walked], LL),
        %print(LL),
        %sleep(1),
        %print('\nDown '),
        walk(Down, End, Max, [Start|Walked], LD),
        %print(LD),
        %sleep(1),
        %print('\nUp '),
        walk(Up, End, Max, [Start|Walked], LU),
        %print(LU),
        %Length is min(LR, min(LL, min(LU, LD))).
        Length is min(LR, min(LL, min(LU, LD))),
        print('min: '),
        %print(LR),
        %print(' '),
        %print(LL),
        %print(' '),
        %print(LU),
        %print(' '),
        %print(LD),
        %print(')\n'),
        print(Length),
        print('\n').
        %sleep(1).
        
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
        ((StartX < Max, \+memberchk((Xright, StartY), Walked)) -> Right = (Xright, StartY); Right = blocked),
        %Left?
        (StartX > 0, \+memberchk((Xleft, StartY), Walked) -> Left = (Xleft, StartY); Left = blocked),
        %Up?
        (StartY > 0, \+memberchk((StartX, Yup), Walked) -> Up = (StartX, Yup); Up = blocked),
        %Down?
        (StartY < Max, \+memberchk((StartX, Ydown), Walked) -> Down = (StartX, Ydown); Down = blocked),
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
/* -*- Mode:Prolog; coding:iso-8859-1; -*- */
:- use_module(library(random)).
:- use_module(library(system)).
%:- use_module(library(lists)).


%Initiate random module
init :-
        use_module(library(random)).

%Reached end of world
walk(Start, End, Max, Walked, Success, Length) :-
        Start = blocked,
        Success = no,
        Length = 9999999.

%Walked to somewhere I've been before
walk(Start, End, Max, Walked, Success, Length) :-
        memberchk(Start, Walked),
        Success = no,
        Length = 9999999.

%Reached the end (goal)
walk((Xs,Ys), (Xe,Ye), _, Walked, Success, Length) :-
        Xs =:= Xe,
        Ys =:= Ye,
        Success = yes,
        length(Walked, Length).

%Try walking in all directions
walk(Start, End, Max, Walked, Success, Length) :-
        possible_steps(Start, Max, (Right, Left, Up, Down)),
        %(Right \= blocked, \+memberchk(Right, Walked) -> walk(Right, End, [Start|Walked], SuccessRight, LengthRight)).
        walk(Right, End, Max, [Start|Walked], Success, Length);
        walk(Left, End, Max, [Start|Walked], Success, Length);
        walk(Up, End, Max, [Start|Walked], Success, Length);
        walk(Down, End, Max, [Start|Walked], Success, Length).

        %walk(Right, End, Max, [Start|Walked], SuccessRight, LengthRight),
        %walk(Left, End, Max, [Start|Walked], SuccessLeft, LengthLeft),
        %walk(Up, End, Max, [Start|Walked], SuccessUp, LengthUp),
        %walk(Down, End, Max, [Start|Walked], SuccessDown, LengthDown),
        %Success = yes,
        %Length = min(LengthRight, min(LengthLeft, min(LengthUp, LengthDown))).

%Give a list of possible walk destinations
possible_steps((StartX, StartY), Max, Walks) :-
        %Right?
        (StartX < Max -> Right = (StartX+1, StartY); Right = blocked),
        %Left?
        (StartX > 0 -> Left = (StartX-1, StartY); Left = blocked),
        %Up?
        (StartY > 0 -> Up = (StartX, StartY-1); Up = blocked),
        %Down?
        (StartY < Max -> Down = (StartX, StartY+1); Down = blocked),
        
        Walks = (Right, Left, Up, Down).
/* -*- Mode:Prolog; coding:iso-8859-1; -*- */
:- use_module(library(random)).
:- use_module(library(system)).


%Initiate random module
init :-
        use_module(library(random)).

%Walk one step in a random direction
walk(Before, Max, After) :-
        possible_walks(Before, Max, Walks),
        random_member(After, Walks).

%Give a list of possible walk destinations
possible_walks((StartX, StartY), Max, Walks) :-
        %Right?
        (StartX < Max -> Right = (StartX+1, StartY); Right = (StartX, StartY)),
        %Left?
        (StartX > 0 -> Left = (StartX-1, StartY); Left = (StartX, StartY)),
        %Up?
        (StartY > 0 -> Up = (StartX, StartY-1); Up = (StartX, StartY)),
        %Down?
        (StartY < Max -> Down = (StartX, StartY+1); Down = (StartX, StartY)),
        
        Walks = [Right, Left, Up, Down].

%Find a path from Start to End
find((Cx, Cy), (Gx, Gy), Max, Steps) :-
        Cx =:= Gx,
        Cy =:= Gy,
        print('Reached goal!\n'),
        print(Steps).

find(Current, Goal, Max, Steps) :-
        walk(Current, Max, Step),
        print(Current),
        print('\n'),
        %sleep(1),
        find(Step, Goal, Max, [Step | Steps]).
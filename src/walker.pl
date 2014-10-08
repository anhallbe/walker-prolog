/* -*- Mode:Prolog; coding:iso-8859-1; -*- */
:- use_module(library(random)).
:- use_module(library(system)).
%:- use_module(library(lists)).


%Initiate random module
init :-
        use_module(library(random)).

%Walk one step in a random direction
step(Before, Max, After) :-
        possible_steps(Before, Max, Walks),
        random_member(After, Walks).

%Give a list of possible walk destinations
possible_steps((StartX, StartY), Max, Walks) :-
        %Right?
        (StartX < Max -> Right = (StartX+1, StartY); Right = (StartX, StartY)),
        %Left?
        (StartX > 0 -> Left = (StartX-1, StartY); Left = (StartX, StartY)),
        %Up?
        (StartY > 0 -> Up = (StartX, StartY-1); Up = (StartX, StartY)),
        %Down?
        (StartY < Max -> Down = (StartX, StartY+1); Down = (StartX, StartY)),
        
        Walks = [Right, Left, Up, Down].

%Find a path from Start(x,y) to End(x,y). The world coordinates are [0,Max].
walk((Cx, Cy), (Gx, Gy), Max, Path, NSteps) :-
        Cx =:= Gx,
        Cy =:= Gy,
        print('Reached goal!\n'),
        print(Path),
        print('\n'),
        length(Path, NSteps).

walk(Current, Goal, Max, Path, NSteps) :-
        step(Current, Max, Step),
        %print(Current),
        %print('\n'),
        %sleep(1),
        walk(Step, Goal, Max, [Step | Path], NSteps).

find(Start, End, Max, Steps) :-
        walk(Start, End, Max, [], Steps),
        print('Found a path with '),
        print(Steps),
        print(' steps.\n'), !.
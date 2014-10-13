%Andreas Hallberg, ID2213 Logic Programming, KTH, 2014
:- module(walker, [find/6]).

:- use_module(library(lists)).

%Find a path from Start to End through a NxN grid, avoiding all Obstacles.
%It finds the shortest possible Path, i.e the one with the least Steps.
%Start and End are coordinates (X,Y), with values [0,Coord,N)
%Obstacles and Path is a list of coordinates. Steps is an integer.
find(Start, End, Obstacles, N, Path, Steps) :-
        print('Looking for paths...\n'),
        findall(X, walk(Start, End, Obstacles, N, [Start], X), All),
        
        print('Found '),
        length(All, Total),
        print(Total),
        print(' paths, finding shortest...\n'),
        
        shortest_path(All, Shortest),
        reverse(Shortest, Path),
        length(Path, Steps),
        
        print('Shortest path ('),
        print(Steps),
        print(' steps): '),
        print(Path),
        print('.\n').
        %walk(Start, End, N, [], Path),
        %length(Path, Steps).

%Base: Found the goal, no need to walk further.
walk((Xs, Ys), (Xe, Ye), _, _, Walked, Path) :-
        Xs =:= Xe,
        Ys =:= Ye,
        Path = Walked.
        %reverse(Walked, Path).

%True if I can move in some direction
walk(Current, Goal, Obstacles, N, Walked, Path) :-
        walk_right(Current, Goal, Obstacles, N, Walked, Path);
        walk_left(Current, Goal, Obstacles, N, Walked, Path);
        walk_up(Current, Goal, Obstacles, N, Walked, Path);
        walk_down(Current, Goal, Obstacles, N, Walked, Path).

%True if I can move to the right
walk_right((Xc, Yc), Goal, Obstacles, N, Walked, Path) :-
        Xn is Xc+1,
        Yn is Yc,
        Xn < N,
        \+memberchk((Xn, Yn), Walked),
        \+memberchk((Xn, Yn), Obstacles),
        walk((Xn,Yn), Goal, Obstacles, N, [(Xn,Yn)|Walked], Path).

%True if I can move down
walk_down((Xc, Yc), Goal, Obstacles, N, Walked, Path) :-
        Xn is Xc,
        Yn is Yc+1,
        Yn < N,
        \+memberchk((Xn, Yn), Walked),
        \+memberchk((Xn, Yn), Obstacles),
        walk((Xn,Yn), Goal, Obstacles, N, [(Xn,Yn)|Walked], Path).

%True if I can move to the left
walk_left((Xc, Yc), Goal, Obstacles, N, Walked, Path) :-
        Xn is Xc-1,
        Yn is Yc,
        Xn >= 0,
        \+memberchk((Xn, Yn), Walked),
        \+memberchk((Xn, Yn), Obstacles),
        walk((Xn,Yn), Goal, Obstacles, N, [(Xn,Yn)|Walked], Path).

%True if I can move up
walk_up((Xc, Yc), Goal, Obstacles, N, Walked, Path) :-
        Xn is Xc,
        Yn is Yc-1,
        Yn >= 0,
        \+memberchk((Xn, Yn), Walked),
        \+memberchk((Xn, Yn), Obstacles),
        walk((Xn,Yn), Goal, Obstacles, N, [(Xn,Yn)|Walked], Path).


%Find the Shortest path (list)
shortest_path([P|T], Shortest) :-
        shortest_path(T, P, Shortest).

%Helper predicates
shortest_path([], Shorter, Res) :-
        Res = Shorter.

shortest_path([Shorter|Rest], Longer, R) :-
        shorter_list(Shorter, Longer),
        shortest_path(Rest, Shorter, R).

shortest_path([_|Rest], Shorter, R) :-
        shortest_path(Rest, Shorter, R).
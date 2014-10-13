:- use_module(library(lists)).

%Find a path from Start to End through a NxN world.
find(Start, End, N, Path, Steps) :-
        print('Looking for paths...\n'),
        findall(X, walk(Start, End, N, [], X), All),
        
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
walk((Xs, Ys), (Xe, Ye), _, Walked, Path) :-
        Xs =:= Xe,
        Ys =:= Ye,
        Path = Walked.
        %reverse(Walked, Path).

%True if I can move in any direction
walk(Current, Goal, N, Walked, Path) :-
        walk_right(Current, Goal, N, Walked, Path);
        walk_down(Current, Goal, N, Walked, Path);
        walk_left(Current, Goal, N, Walked, Path);
        walk_up(Current, Goal, N, Walked, Path).

%True if I can move to the right
walk_right((Xc, Yc), Goal, N, Walked, Path) :-
        Xn is Xc+1,
        Yn is Yc,
        Xn < N,
        \+memberchk((Xn, Yn), Walked),
        walk((Xn,Yn), Goal, N, [(Xn,Yn)|Walked], Path).

%True if I can move down
walk_down((Xc, Yc), Goal, N, Walked, Path) :-
        Xn is Xc,
        Yn is Yc+1,
        Yn < N,
        \+memberchk((Xn, Yn), Walked),
        walk((Xn,Yn), Goal, N, [(Xn,Yn)|Walked], Path).

%True if I can move to the left
walk_left((Xc, Yc), Goal, N, Walked, Path) :-
        Xn is Xc-1,
        Yn is Yc,
        Xn > 0,
        \+memberchk((Xn, Yn), Walked),
        walk((Xn,Yn), Goal, N, [(Xn,Yn)|Walked], Path).

%True if I can move up
walk_up((Xc, Yc), Goal, N, Walked, Path) :-
        Xn is Xc,
        Yn is Yc-1,
        Yn > 0,
        \+memberchk((Xn, Yn), Walked),
        walk((Xn,Yn), Goal, N, [(Xn,Yn)|Walked], Path).


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
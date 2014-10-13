:- use_module(library(lists)).

%Find a path from Start to End through a NxN world.
find(Start, End, N, Path, Steps) :-
        walk(Start, End, N, [], Path),
        length(Path, Steps).

walk((Xs, Ys), (Xe, Ye), _, Walked, Path) :-
        Xs =:= Xe,
        Ys =:= Ye,
        reverse(Walked, Path).

walk(Current, Goal, N, Walked, Path) :-
        walk_right(Current, Goal, N, Walked, Path);
        walk_down(Current, Goal, N, Walked, Path);
        walk_left(Current, Goal, N, Walked, Path);
        walk_up(Current, Goal, N, Walked, Path).

walk_right((Xc, Yc), Goal, N, Walked, Path) :-
        Xn is Xc+1,
        Yn is Yc,
        Xn < N,
        \+memberchk((Xn, Yn), Walked),
        walk((Xn,Yn), Goal, N, [(Xn,Yn)|Walked], Path).

walk_down((Xc, Yc), Goal, N, Walked, Path) :-
        Xn is Xc,
        Yn is Yc+1,
        Yn < N,
        \+memberchk((Xn, Yn), Walked),
        walk((Xn,Yn), Goal, N, [(Xn,Yn)|Walked], Path).

walk_left((Xc, Yc), Goal, N, Walked, Path) :-
        Xn is Xc-1,
        Yn is Yc,
        Xn > 0,
        \+memberchk((Xn, Yn), Walked),
        walk((Xn,Yn), Goal, N, [(Xn,Yn)|Walked], Path).

walk_up((Xc, Yc), Goal, N, Walked, Path) :-
        Xn is Xc,
        Yn is Yc-1,
        Yn > 0,
        \+memberchk((Xn, Yn), Walked),
        walk((Xn,Yn), Goal, N, [(Xn,Yn)|Walked], Path).
% Facts: Define battlefield terrain and troop movements
terrain(hill, difficult).
terrain(plain, easy).
terrain(forest, moderate).
terrain(river, impassable).

troops(infantry, moderate).
troops(artillery, slow).
troops(cavalry, fast).

enemy_position(e1, hill).
enemy_position(e2, forest).
enemy_position(e3, plain).

% Define movement costs based on troop type and terrain
movement_cost(infantry, hill, 5).
movement_cost(infantry, plain, 1).
movement_cost(infantry, forest, 3).
movement_cost(infantry, river, inf).

movement_cost(artillery, hill, 8).
movement_cost(artillery, plain, 3).
movement_cost(artillery, forest, 5).
movement_cost(artillery, river, inf).

movement_cost(cavalry, hill, 6).
movement_cost(cavalry, plain, 1).
movement_cost(cavalry, forest, 2).
movement_cost(cavalry, river, inf).

% Rules: Calculate the total cost to move troops to a target location
plan_troop_movement(Troop, Target, Cost) :-
    troops(Troop, _),
    terrain(Target, _),
    movement_cost(Troop, Target, Cost),
    Cost \= inf.

% Strategy: Determine the best troop type to attack an enemy position
best_attack(Enemy, BestTroop, Cost) :-
    enemy_position(Enemy, Terrain),
    findall((C, T), plan_troop_movement(T, Terrain, C), Results),
    sort(Results, [(Cost, BestTroop)|_]).

% Export data for Python visualization
export_data(File) :-
    open(File, write, Stream),
    forall(
        enemy_position(Enemy, Terrain),
        (
            best_attack(Enemy, BestTroop, Cost),
            format(Stream, "~w,~w,~w,~d\n", [Enemy, Terrain, BestTroop, Cost])
        )
    ),
    close(Stream).

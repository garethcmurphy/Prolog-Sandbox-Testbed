% Define dynamic predicates for flexibility
:- dynamic cost/2.
:- dynamic priority/2.
:- dynamic resource/2.
:- dynamic allocation/3.

% Example: Loading budget-related facts
% Costs for data management activities
cost(data_curation, 50000). % Cost in Euros
cost(infrastructure, 100000).
cost(training, 30000).
cost(automation_tools, 40000).
cost(consultants, 70000).

% Priority levels for activities (1 = highest priority, 5 = lowest priority)
priority(data_curation, 1).
priority(infrastructure, 1).
priority(training, 2).
priority(automation_tools, 3).
priority(consultants, 4).

% Available resources (budget and headcount)
resource(budget, 200000). % Total yearly budget
resource(headcount, 10).  % Total team members

% Allocations (Activity, Resource Type, Amount)
allocation(data_curation, budget, 50000).
allocation(data_curation, headcount, 3).
allocation(infrastructure, budget, 100000).
allocation(training, budget, 30000).
allocation(training, headcount, 2).
allocation(automation_tools, budget, 40000).
allocation(consultants, budget, 70000).

% Rules for budget-related queries
% Check if an activity is within budget
within_budget(Activity) :-
    allocation(Activity, budget, Allocated),
    resource(budget, TotalBudget),
    Allocated =< TotalBudget.

% Check if the total budget exceeds available funds
total_budget_exceeds :-
    findall(Allocated, allocation(_, budget, Allocated), Allocations),
    sum_list(Allocations, TotalAllocated),
    resource(budget, TotalBudget),
    TotalAllocated > TotalBudget.

% Suggest reallocations based on priority
suggest_reallocation(FromActivity, ToActivity) :-
    allocation(FromActivity, budget, AllocatedFrom),
    allocation(ToActivity, budget, AllocatedTo),
    priority(FromActivity, PriorityFrom),
    priority(ToActivity, PriorityTo),
    PriorityFrom > PriorityTo, % Lower priority activity
    NewAllocatedTo is AllocatedTo + AllocatedFrom // 2, % Reallocate 50%
    NewAllocatedFrom is AllocatedFrom // 2, % Keep 50%
    format("Reallocate €~w from ~w to ~w. New allocations: ~w (€~w), ~w (€~w).~n",
           [AllocatedFrom // 2, FromActivity, ToActivity, FromActivity, NewAllocatedFrom, ToActivity, NewAllocatedTo]).

% Optimize budget allocation for highest priority activities
optimize_budget :-
    findall((Activity, Priority), priority(Activity, Priority), Priorities),
    sort(2, @=<, Priorities, SortedPriorities), % Sort by priority
    allocate_budget(SortedPriorities).

allocate_budget([]).
allocate_budget([(Activity, _Priority) | Rest]) :-
    within_budget(Activity),
    format("Activity ~w is within budget.~n", [Activity]),
    allocate_budget(Rest).
allocate_budget([(Activity, _Priority) | Rest]) :-
    \+ within_budget(Activity),
    format("Activity ~w exceeds budget. Consider reallocations.~n", [Activity]),
    allocate_budget(Rest).

% Example queries:
% - Check if an activity is within budget:
%   ?- within_budget(data_curation).
%
% - Find if total budget exceeds available funds:
%   ?- total_budget_exceeds.
%
% - Suggest reallocations to higher-priority activities:
%   ?- suggest_reallocation(consultants, data_curation).
%
% - Optimize the budget based on priorities:
%   ?- optimize_budget.

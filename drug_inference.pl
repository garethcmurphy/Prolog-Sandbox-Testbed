% Define targets and their associated conditions
target(insulin_receptor, diabetes).
target(glp1_receptor, diabetes).
target(sglt2, diabetes).

% Define drugs and their targets
drug_target(trulicity, glp1_receptor).
drug_target(ozempic, glp1_receptor).
drug_target(jardiance, sglt2).

% Define drug mechanisms
mechanism_of_action(trulicity, "GLP-1 receptor agonist").
mechanism_of_action(ozempic, "GLP-1 receptor agonist").
mechanism_of_action(jardiance, "SGLT2 inhibitor").

% Define drug indications
indicated_for(trulicity, diabetes).
indicated_for(ozempic, diabetes).
indicated_for(jardiance, diabetes).

% Rules for inferring drug relevance
relevant_drug_for_target(Drug, Target) :-
    drug_target(Drug, Target).

relevant_drug_for_condition(Drug, Condition) :-
    target(Target, Condition),
    drug_target(Drug, Target).

% Example queries:
% - Which drugs target the GLP-1 receptor?:
%   ?- relevant_drug_for_target(Drug, glp1_receptor).
%
% - Which drugs are relevant for diabetes?:
%   ?- relevant_drug_for_condition(Drug, diabetes).
%
% - What is the mechanism of action for a drug?:
%   ?- mechanism_of_action(Drug, Mechanism).

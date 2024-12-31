% Define dynamic predicates to allow loading data dynamically
:- dynamic target/2.
:- dynamic drug_target/2.
:- dynamic mechanism_of_action/2.
:- dynamic indicated_for/2.

% Example: Adding facts dynamically from a dataset (can be generated programmatically)
% These facts could come from Open Targets or similar datasets.
load_data :-
    % Targets and their conditions
    assertz(target(glp1_receptor, diabetes)),
    assertz(target(insulin_receptor, diabetes)),
    assertz(target(sglt2, diabetes)),
    assertz(target(pdgfr, cancer)),
    assertz(target(vegfr, cancer)),

    % Drugs and their targets
    assertz(drug_target(trulicity, glp1_receptor)),
    assertz(drug_target(ozempic, glp1_receptor)),
    assertz(drug_target(jardiance, sglt2)),
    assertz(drug_target(avastin, vegfr)),
    assertz(drug_target(imatinib, pdgfr)),

    % Drug mechanisms
    assertz(mechanism_of_action(trulicity, "GLP-1 receptor agonist")),
    assertz(mechanism_of_action(ozempic, "GLP-1 receptor agonist")),
    assertz(mechanism_of_action(jardiance, "SGLT2 inhibitor")),
    assertz(mechanism_of_action(avastin, "VEGFR inhibitor")),
    assertz(mechanism_of_action(imatinib, "PDGFR inhibitor")),

    % Indications for drugs
    assertz(indicated_for(trulicity, diabetes)),
    assertz(indicated_for(ozempic, diabetes)),
    assertz(indicated_for(jardiance, diabetes)),
    assertz(indicated_for(avastin, cancer)),
    assertz(indicated_for(imatinib, cancer)).

% Rules for querying drug discovery relationships

% Find drugs for a specific target
relevant_drug_for_target(Drug, Target) :-
    drug_target(Drug, Target).

% Find drugs for a specific condition
relevant_drug_for_condition(Drug, Condition) :-
    target(Target, Condition),
    drug_target(Drug, Target).

% Retrieve the mechanism of action for a drug
get_mechanism_of_action(Drug, Mechanism) :-
    mechanism_of_action(Drug, Mechanism).

% Find conditions treated by a drug
condition_treated_by_drug(Condition, Drug) :-
    indicated_for(Drug, Condition).

% Example query: Find targets for a specific condition
targets_for_condition(Condition, Target) :-
    target(Target, Condition).

% Find all drugs for a condition
drugs_for_condition(Condition, Drug) :-
    target(Target, Condition),
    drug_target(Drug, Target).

% Example queries:
% - What drugs target GLP-1 receptor?
%   ?- relevant_drug_for_target(Drug, glp1_receptor).
% - What drugs are relevant for diabetes?
%   ?- relevant_drug_for_condition(Drug, diabetes).
% - What is the mechanism of action for Ozempic?
%   ?- get_mechanism_of_action(ozempic, Mechanism).
% - What conditions are treated by Jardiance?
%   ?- condition_treated_by_drug(Condition, jardiance).

# Prolog Sandbox Testbed 🧠💻  

This repository provides a sandbox environment for experimenting with Prolog. It allows you to test various constructs, query capabilities, and explore what is possible with Prolog's logical programming paradigm.

---

## Features ✨  

- **Experiment with Prolog Constructs**: Test rules, facts, and logical constructs.  
- **Run Queries**: Explore Prolog's inference engine with custom queries.  
- **Testbed for Learning**: Ideal for beginners and advanced users to prototype ideas.  

---

## Prerequisites 🛠️  

- A Prolog interpreter installed (e.g., [SWI-Prolog](https://www.swi-prolog.org/)).  

---

## Installation  

1. Clone the repository:  
git clone https://github.com/your-username/prolog-sandbox.git  
cd prolog-sandbox  

2. Open the Prolog interpreter:  
swipl  

3. Load the testbed file:  
[load_file('sandbox.pl')].  

---

## Usage 🔧  

1. Add your rules and facts to `sandbox.pl`.  
2. Run queries in the Prolog interpreter:  
   Example:  
   ?- parent(john, mary).  

3. Experiment with various Prolog constructs, such as:  
   - Recursion  
   - Backtracking  
   - Arithmetic operations  

---

## File Structure 📂  

- `sandbox.pl`: Main Prolog file for rules, facts, and queries.  
- `README.md`: Documentation for the repository.  

---

## Example Prolog Code  

```prolog
% Facts
parent(john, mary).
parent(mary, susan).

% Rules
grandparent(X, Y) :- parent(X, Z), parent(Z, Y).

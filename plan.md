# The 6-Week Syllabus: Logic and Foundations of Computer Science (Part 2)

## Week 1: From Lambda Calculus to Rocq
- **Concepts:** Introduction to the jsCoq environment. Gallina (the term language) vs. Vernacular (commands) vs. Ltac (tactics).
- **Hands-on:** Writing exact lambda-terms for minimal logic (combinators like I, K, S) using `Definition` and `fun`. Transitioning to `Lemma` and basic tactics (`intros`, `apply`, `exact`) to build the exact same terms interactively. Using `Show Proof`.

## Week 2: Propositional Logic & The Tactic Meta-Language
- **Concepts:** Backward reasoning via natural deduction rules. Introducing the standard logical connectives (∧, ∨, →, ¬, ⊥) as black boxes first.
- **Hands-on:** Tactics for connectives (split, left/right, destruct, intro for negation). Proving basic propositional tautologies.

## Week 3: First-Order Logic & Equality
- **Concepts:** Universal (∀) and existential (∃) quantification. The Π-type in dependent type theory. Leibniz equality vs. definitional equality.
- **Hands-on:** Tactics `exists`, `rewrite`, `reflexivity`. Proving basic syllogisms and quantifier equivalences.

## Week 4: The Meaning of Logical Constants (Epistemology of Data Types)
- **Concepts:** Martin-Löf's justification of logical laws. Verificationist meaning (Constructors) vs. Pragmatist meaning (Eliminators/Pattern matching). Opening on Dummett's harmony (quick reference to Zeilberger's "On the unity of duality" for applications to programming?) and/or Church encodings in the Calculus of Constructions.
- **Hands-on:** Looking under the hood. How `and` and `or` are actually defined in Rocq using `Inductive`. Using `match ... with` to manually destruct proofs instead of using the `destruct` tactic.

## Week 5: Induction & Functional Programming
- **Concepts:** Peano arithmetic. Inductive types for data (Natural numbers, Lists) rather than propositions. Recursive functions.
- **Hands-on:** Defining `nat` and `list`. Writing simple functions with `Fixpoint` (e.g., addition, append, reverse). The `induction` tactic.

## Week 6: Formal Verification & The Philosophy of Trust
- **Concepts:** The de Bruijn criterion. What does it mean to "trust" a machine? Epistemic implications for AI.
- **Hands-on:** Proving that reversing a list twice yields the original list (`rev (rev l) = l`).
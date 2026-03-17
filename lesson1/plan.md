# Lesson 1: Battle Plan (2 Hours)
Since you have 5 days, here is exactly how you can structure your 2-hour jsCoq workshop this week.

## Part 1: The Presentation (20-30 minutes)
- **Context:** Welcome them to the second half of the course. Explain that they have studied the theory of lambda calculus; now, they will use a machine that checks it.
- **The Architecture:** Briefly explain the three layers of Rocq:
    - **Gallina:** The core language of terms (where the lambda calculus lives).
    - **The Vernacular:** Commands starting with capital letters (`Definition`, `Check`, `Print`) that talk to the system.
    - **Ltac (Tactics):** The language used to interactively construct Gallina terms.
- **jsCoq Tour:** Show them the interface on the projector: the editor on the left, the state/goals on the right.

## Part 2: Workshop Phase A - Term Mode (30 minutes)
- **Goal:** Recreate the I and K combinators from their previous classes using raw Gallina syntax.
- **Guided Exercise:** Have them type along with you in jsCoq:
    - Declare some propositional variables: `Variables A B C : Prop.`
    - Write the Identity term: `Definition I : A -> A := fun x => x.`
    - Write the K combinator: `Definition K : A -> B -> A := fun x y => x.`
    - Use `Check I.` and `Print K.` to see how the machine validates the types.

## Part 3: The Tactic State Presentation (15 minutes)
- **Concept:** Explain that writing raw lambda terms works for A→A, but is a nightmare for complex proofs.
- **The Shift:** Introduce tactics as a way to work backwards from a goal, matching the bottom-up reading of natural deduction rules. Explain that the machine will build the `fun x => ...` for them.

## Part 4: Workshop Phase B - Tactic Mode (40 minutes)
- **Goal:** Reprove I, K, and a simple transitivity lemma using tactics, observing the proof object grow.
- **Guided Exercise:**
    - Start the proof of identity: `Lemma I_tac : A -> A.`
    - Show them the goal state.
    - Run `intro x.` Ask them what happened to the goal. Run `Show Proof.` to reveal the hidden `(fun x : A => ?Goal)`.
    - Run `exact x.` Run `Show Proof.` again to show the complete term. Close with `Qed.`
    - Have them prove K independently using tactics.
    - Challenge: Have them prove transitivity: `Lemma trans : (A -> B) -> (B -> C) -> (A -> C).` introducing the `apply` tactic.

## Part 5: Wrap-up and Homework Assignment (5 minutes)
- Assign 2 or 3 minimal logic lemmas (like the S combinator or hypothetical syllogism) to complete in jsCoq for next week.

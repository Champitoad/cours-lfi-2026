(****************************************************************)
(* Exercices bonus : Toutes les tautologies d'Edukera           *)
(****************************************************************)

Section Tautologies.

Variables (A B C D : Prop).

(** # Connectives *)

(** ### Conjunction *)

Lemma tautologie_4 :
  A -> B -> A /\ B.
Proof.
  (* À compléter *)
Admitted.
Print tautologie_4.

Lemma tautologie_5 :
  A -> B -> C -> A /\ (B /\ C).
Proof.
  (* À compléter *)
Admitted.
Print tautologie_5.

Lemma tautologie_6 :
  (A /\ B) -> (C -> A).
Proof.
  (* À compléter *)
Admitted.
Print tautologie_6.

Lemma tautologie_7 :
  (A /\ B) -> (C -> B).
Proof.
  (* À compléter *)
Admitted.
Print tautologie_7.

Lemma tautologie_8 :
  (A /\ B) -> (B /\ A).
Proof.
  (* À compléter *)
Admitted.
Print tautologie_8.


(** ### Disjunction *)

Lemma tautologie_9 :
  A -> A \/ B.
Proof.
  (* À compléter *)
Admitted.
Print tautologie_9.

Lemma tautologie_10 :
  B -> A \/ B.
Proof.
  (* À compléter *)
Admitted.
Print tautologie_10.

Lemma tautologie_11 :
  B -> A \/ (B \/ C).
Proof.
  (* À compléter *)
Admitted.
Print tautologie_11.

Lemma tautologie_12 :
  A \/ B -> (A -> B) -> B.
Proof.
  (* À compléter *)
Admitted.
Print tautologie_12.

Lemma tautologie_13 :
  A \/ B -> (B \/ A).
Proof.
  (* À compléter *)
Admitted.
Print tautologie_13.


(** ### Negation *)

Lemma tautologie_14 :
  False -> ~ A.
Proof.
  (* À compléter *)
Admitted.
Print tautologie_14.

Lemma tautologie_15 :
  ~ A -> A -> False.
Proof.
  (* À compléter *)
Admitted.
Print tautologie_15.

Lemma tautologie_16 :
  A -> ~ ~ A.
Proof.
  (* À compléter *)
Admitted.
Print tautologie_16.

Lemma tautologie_17 :
  False -> A.
Proof.
  (* À compléter *)
Admitted.
Print tautologie_17.

Lemma tautologie_18 :
  ~ A -> A -> B.
Proof.
  (* À compléter *)
Admitted.
Print tautologie_18.

Lemma tautologie_19 :
  A -> (C -> ~ B) -> (A -> B) -> ~ C.
Proof.
  (* À compléter *)
Admitted.
Print tautologie_19.

Lemma tautologie_20 :
  (A -> B) /\ (A -> ~ B) -> ~ A.
Proof.
  (* À compléter *)
Admitted.
Print tautologie_20.

Lemma tautologie_21 :
  (A \/ ~ B) /\ B -> A.
Proof.
  (* À compléter *)
Admitted.
Print tautologie_21.

Lemma tautologie_22 :
  ~ A \/ B -> A -> B.
Proof.
  (* À compléter *)
Admitted.
Print tautologie_22.

Lemma tautologie_23 :
  (A -> B) -> (~ B -> ~ A).
Proof.
  (* À compléter *)
Admitted.
Print tautologie_23.


(** ## Exercises *)

(** ### Constructive logic *)

Lemma tautologie_24 :
  A /\ B -> C -> A.
Proof.
  (* À compléter *)
Admitted.
Print tautologie_24.

Lemma tautologie_25 :
  A /\ B -> C -> B /\ C.
Proof.
  (* À compléter *)
Admitted.
Print tautologie_25.

Lemma tautologie_26 :
  A -> A /\ (A \/ B).
Proof.
  (* À compléter *)
Admitted.
Print tautologie_26.

Lemma tautologie_27 :
  A \/ (B /\ C) -> A \/ B.
Proof.
  (* À compléter *)
Admitted.
Print tautologie_27.

Lemma tautologie_28 :
  A \/ B -> (A -> B) -> B.
Proof.
  (* À compléter *)
Admitted.
Print tautologie_28.

Lemma tautologie_29 :
  (A -> B -> C) -> ((A -> B) -> A -> C).
Proof.
  (* À compléter *)
Admitted.
Print tautologie_29.

Lemma tautologie_30 :
  (A -> B -> C) -> A /\ B -> C.
Proof.
  (* À compléter *)
Admitted.
Print tautologie_30.

Lemma tautologie_31 :
  (A -> B) -> (A -> C) -> A -> B /\ C.
Proof.
  (* À compléter *)
Admitted.
Print tautologie_31.

Lemma tautologie_32 :
  (A -> B) -> A \/ C -> B \/ C.
Proof.
  (* À compléter *)
Admitted.
Print tautologie_32.

Lemma tautologie_33 :
  (A /\ B) \/ (A \/ B) -> A \/ B.
Proof.
  (* À compléter *)
Admitted.
Print tautologie_33.

Lemma tautologie_34 :
  (A -> C) /\ (B -> C) -> A \/ B -> C.
Proof.
  (* À compléter *)
Admitted.
Print tautologie_34.

Lemma tautologie_35 :
  ~ A \/ B -> A -> B.
Proof.
  (* À compléter *)
Admitted.
Print tautologie_35.

Lemma tautologie_36 :
  (A -> B -> C) -> A /\ B -> C.
Proof.
  (* À compléter *)
Admitted.
Print tautologie_36.

Lemma tautologie_37 :
  A -> (A -> B) -> ((A -> B) -> (B -> C)) -> C.
Proof.
  (* À compléter *)
Admitted.
Print tautologie_37.

Lemma tautologie_38 :
  (A /\ B -> C) <-> A -> B -> C.
Proof.
  (* À compléter *)
Admitted.
Print tautologie_38.

Lemma tautologie_39 :
  (A \/ B -> C) <-> (A -> C) /\ (B -> C).
Proof.
  (* À compléter *)
Admitted.
Print tautologie_39.


(** ### Associativity *)

Lemma tautologie_40 :
  A /\ (B /\ C) <-> (A /\ B) /\ C.
Proof.
  (* À compléter *)
Admitted.
Print tautologie_40.

Lemma tautologie_41 :
  A \/ (B \/ C) <-> (A \/ B) \/ C.
Proof.
  (* À compléter *)
Admitted.
Print tautologie_41.


(** ### Distributivity *)

Lemma tautologie_42 :
  A /\ (B -> C) -> A /\ B -> A /\ C.
Proof.
  (* À compléter *)
Admitted.
Print tautologie_42.

Lemma tautologie_43 :
  A /\ (B \/ C) <-> (A /\ B) \/ (A /\ C).
Proof.
  (* À compléter *)
Admitted.
Print tautologie_43.

Lemma tautologie_44 :
  A \/ (B /\ C) <-> (A \/ B) /\ (A \/ C).
Proof.
  (* À compléter *)
Admitted.
Print tautologie_44.

Lemma tautologie_45 :
  (A -> B) /\ (A -> C) -> (A -> (B /\ C)).
Proof.
  (* À compléter *)
Admitted.
Print tautologie_45.

Lemma tautologie_46 :
  (A -> (B /\ C)) -> (A -> B) /\ (A -> C).
Proof.
  (* À compléter *)
Admitted.
Print tautologie_46.

Lemma tautologie_47 :
  (A -> B) \/ (A -> C) -> (A -> (B \/ C)).
Proof.
  (* À compléter *)
Admitted.
Print tautologie_47.

Lemma tautologie_48 :
  (A -> (B -> C)) -> ((A -> B) -> (A -> C)).
Proof.
  (* À compléter *)
Admitted.
Print tautologie_48.

Lemma tautologie_49 :
  ((A -> B) -> (A -> C)) -> (A -> (B -> C)).
Proof.
  (* À compléter *)
Admitted.
Print tautologie_49.

Lemma tautologie_50 :
  (A \/ B -> C) <-> (A -> C) /\ (B -> C).
Proof.
  (* À compléter *)
Admitted.
Print tautologie_50.


(** ### Classical logic *)

Axiom LEM : forall A, A \/ ~A.

Lemma tautologie_51 :
  (A /\ B -> A /\ C) -> A /\ (B -> C).
Proof.
  (* À compléter *)
Admitted.
Print tautologie_51.

Lemma tautologie_52 :
  (A -> (B \/ C)) -> (A -> B) \/ (A -> C).
Proof.
  (* À compléter *)
Admitted.
Print tautologie_52.


Lemma tautologie_53 :
  A \/ ~ A.
Proof.
  (* À compléter *)
Admitted.
Print tautologie_53.

Lemma tautologie_54 :
  A \/ (A -> B).
Proof.
  (* À compléter *)
Admitted.
Print tautologie_54.

Lemma tautologie_55 :
  (A -> B) \/ (B -> A).
Proof.
  (* À compléter *)
Admitted.
Print tautologie_55.

Lemma tautologie_56 :
  ~ ~ A -> A.
Proof.
  (* À compléter *)
Admitted.
Print tautologie_56.

Lemma tautologie_57 :
  ((A -> B) -> A) -> A.
Proof.
  (* À compléter *)
Admitted.
Print tautologie_57.


Lemma tautologie_58 :
  ~ ~ (A \/ ~ A).
Proof.
  (* À compléter *)
Admitted.
Print tautologie_58.

Lemma tautologie_59 :
  ~ ~ (A \/ (A -> B)).
Proof.
  (* À compléter *)
Admitted.
Print tautologie_59.

Lemma tautologie_60 :
  ~ ~ ((A -> B) \/ (B -> A)).
Proof.
  (* À compléter *)
Admitted.
Print tautologie_60.

Lemma tautologie_61 :
  ~ ~ (~ ~ A -> A).
Proof.
  (* À compléter *)
Admitted.
Print tautologie_61.

Lemma tautologie_62 :
  ~ ~ (((A -> B) -> A) -> A).
Proof.
  (* À compléter *)
Admitted.
Print tautologie_62.

End Tautologies.

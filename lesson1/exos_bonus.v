(****************************************************************)
(* Exercices bonus : Tautologies en logique implicative         *)
(*                                                              *)
(* Ce fichier contient des exercices supplémentaires pour       *)
(* s'entraîner à prouver des tautologies en utilisant Rocq.     *)
(*                                                              *)
(* Pensez à changer les commandes [Admitted] en [Qed] pour      *)
(* vous assurer que vos preuves sont bien complètes !           *)
(****************************************************************)

(**************************************************************)
(* Déclaration des variables pour les tautologies             *)
(**************************************************************)
Section Tautologies.

Variables (A B C D : Prop).

(**************************************************************)
(* Tautologie 1 : A -> ((A -> B) -> B)                        *)
(**************************************************************)
Lemma tautologie_1 :
  A -> ((A -> B) -> B).
Proof.
  (* À compléter *)
Admitted.
Print tautologie_1.

(**************************************************************)
(* Tautologie 2 : (A -> A -> B) -> (A -> B)                   *)
(**************************************************************)
Lemma tautologie_2 :
  (A -> A -> B) -> (A -> B).
Proof.
  (* À compléter *)
Admitted.
Print tautologie_2.

(*******************************************************************)
(* Tautologie 3 : (((A -> B) -> C) -> D) -> (A -> (B -> C) -> D)   *)
(*******************************************************************)
Lemma tautologie_3 :
  (((A -> B) -> C) -> D) -> (A -> (B -> C) -> D).
Proof.
  (* À compléter *)
Admitted.
Print tautologie_3.

End Tautologies.
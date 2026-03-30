(** Exercices Bonus - Leçon 3 (Logique du premier ordre) *)
(** Ces théorèmes vont au-delà du cours, amusez-vous bien ! *)

Section Bonus.

Variable T : Type.
Variable P Q : T -> Prop.
Variable t_defaut : T.

(** * PARTIE 1 : CONSTRUCTIVISME ET QUANTIFICATEURS *)

(** De Morgan: S'il existe un contre-exemple, la propriété universelle est fausse. *)
Lemma de_morgan_forall_1 : (exists x : T, ~ P x) -> ~ (forall x : T, P x).
Proof.
  (* À compléter *)
Admitted.

(** Transitivité sur quantificateurs *)
Lemma exists_impl : (exists x : T, P x) -> (forall x : T, P x -> Q x) -> (exists y : T, Q y).
Proof.
  (* À compléter *)
Admitted.

(** Distribution de l'universel sur la conjonction *)
Lemma forall_and : (forall x : T, P x /\ Q x) <-> (forall x, P x) /\ (forall x, Q x).
Proof.
  (* À compléter *)
Admitted.

(** * PARTIE 2 : LOGIQUE CLASSIQUE *)

(** Attention: le constructivisme seul ne suffit plus ici ! *)
Axiom LEM : forall A : Prop, A \/ ~ A.

(** De Morgan (Réciproque): Si l'universel est faux, on DOIT alors pouvoir dégager un contre-exemple ! (Classique) *)
Lemma de_morgan_forall_2 : ~ (forall x : T, P x) -> (exists x : T, ~ P x).
Proof.
  (* À compléter *)
Admitted.

(** Le Paradoxe du Buveur: "Dans tout bar non vide, il y a une personne telle que, si elle boit, alors tout le monde boit." *)
Lemma paradoxe_buveur : exists x : T, (P x -> forall y : T, P y).
Proof.
  (* Indice : Faites une disjonction de cas (LEM) sur (forall y, P y) *)
  (* À compléter *)
Admitted.

End Bonus.

(** Script d'accompagnement - Live Coding Leçon 3 *)
(** Ces exemples accompagnent directement la présentation Beamer. *)

Section Cours.

Variable T : Type.
Variable P Q : T -> Prop.

(** 1. Le pour-tout (forall) *)

Lemma demo_forall : (forall x : T, P x -> Q x) -> (forall x : T, P x) -> (forall y : T, Q y).
Proof.
  intros H_impl H_P.
  intro y.
  apply H_impl.
  apply H_P.
Qed.

(** 2. L'existence (exists) *)

Variable t0 : T. (* Nécessaire en constructivisme pour éviter les modèle non-vide. *)

Lemma demo_exists : (forall x : T, P x) -> (exists y : T, P y).
Proof.
  intro H_P.
  exists t0.
  apply H_P.
Qed.

Lemma demo_exists_elim : (exists x : T, P x /\ Q x) -> (exists y : T, P y).
Proof.
  intros H_ex.
  destruct H_ex as [x H_PQ].
  destruct H_PQ as [H_P H_Q].
  exists x.
  exact H_P.
Qed.

(** 3. L'égalité propositionnelle et définitionnelle *)

Lemma demo_egalite : forall x y : T, x = y -> y = x.
Proof.
  intros x y H.
  rewrite H.
  reflexivity.
Qed.

Definition doubler (n : nat) := n + n.

Lemma demo_def : doubler 2 = 4.
Proof.
  unfold doubler.
  simpl.
  reflexivity.
Qed.

End Cours.

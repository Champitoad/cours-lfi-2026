(** Exercices Bonus - Leçon 3 (Logique du premier ordre) - SOLUTIONS *)
(** Ces théorèmes vont au-delà du cours, amusez-vous bien ! *)

Section Bonus.

Variable T : Type.
Variable P Q : T -> Prop.
Variable t_defaut : T.

(** * PARTIE 1 : CONSTRUCTIVISME ET QUANTIFICATEURS *)

(** De Morgan: S'il existe un contre-exemple, la propriété universelle est fausse. *)
Lemma de_morgan_forall_1 : (exists x : T, ~ P x) -> ~ (forall x : T, P x).
Proof.
  intros H_exists H_forall.
  destruct H_exists as [x H_not_px].
  apply H_not_px.
  apply H_forall.
Qed.

(** Transitivité sur quantificateurs *)
Lemma exists_impl : (exists x : T, P x) -> (forall x : T, P x -> Q x) -> (exists y : T, Q y).
Proof.
  intros H_exists H_impl.
  destruct H_exists as [x H_px].
  exists x.
  apply H_impl.
  exact H_px.
Qed.

(** Distribution de l'universel sur la conjonction *)
Lemma forall_and : (forall x : T, P x /\ Q x) <-> (forall x, P x) /\ (forall x, Q x).
Proof.
  split.
  - intros H_forall.
    split.
    + intro x. 
      destruct (H_forall x) as [H_px _]. 
      exact H_px.
    + intro x. 
      destruct (H_forall x) as [_ H_qx]. 
      exact H_qx.
  - intros H_and.
    destruct H_and as [H_forall_p H_forall_q].
    intro x.
    split.
    + apply H_forall_p.
    + apply H_forall_q.
Qed.

(** * PARTIE 2 : LOGIQUE CLASSIQUE *)

(** Attention: le constructivisme seul ne suffit plus ici ! *)
Axiom LEM : forall A : Prop, A \/ ~ A.

(** De Morgan (Réciproque): Si l'universel est faux, on DOIT alors pouvoir dégager un contre-exemple ! (Classique) *)
Lemma de_morgan_forall_2 : ~ (forall x : T, P x) -> (exists x : T, ~ P x).
Proof.
  intros H_not_forall.
  destruct (LEM (exists x : T, ~ P x)) as [H_exists | H_not_exists].
  - exact H_exists.
  - exfalso.
    apply H_not_forall.
    intro x.
    destruct (LEM (P x)) as [H_px | H_not_px].
    + exact H_px.
    + exfalso.
      apply H_not_exists.
      exists x.
      exact H_not_px.
Qed.

(** Le Paradoxe du Buveur: "Dans tout bar non vide, il y a une personne telle que, si elle boit, alors tout le monde boit." *)
Lemma paradoxe_buveur : exists x : T, (P x -> forall y : T, P y).
Proof.
  (* Indice : Faites une disjonction de cas (LEM) sur (forall y, P y) *)
  destruct (LEM (forall y : T, P y)) as [H_tout_le_monde_boit | H_pas_tout_le_monde_boit].
  - (* Si tout le monde boit, n'importe qui fait l'affaire, prenons t_defaut *)
    exists t_defaut.
    intros _ y.
    apply H_tout_le_monde_boit.
  - (* Si au contraire, quelqu'un ne boit pas *)
    (* Par le corollaire de de_morgan, il y a au moins un non-buveur *)
    destruct (de_morgan_forall_2 H_pas_tout_le_monde_boit) as [x H_nx].
    exists x.
    intros H_px y.
    (* C'est impossible par contradiction, car on sait que x ne boit pas *)
    exfalso.
    apply H_nx.
    exact H_px.
Qed.

End Bonus.

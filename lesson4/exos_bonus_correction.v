(** Exercices Bonus — Leçon 4 — CORRECTIONS *)

(** ================================================================ *)
(** * PARTIE 1 : Les encodages de Church — étude complète *)
(** ================================================================ *)

Definition and_Church (A B : Prop) : Prop :=
  forall P : Prop, (A -> B -> P) -> P.

(** EXERCICE 1 *)

Lemma and_vers_Church : forall A B : Prop, A /\ B -> and_Church A B.
Proof.
  intros A B H P f.
  destruct H as [a b].
  exact (f a b).
Qed.

Lemma Church_vers_and : forall A B : Prop, and_Church A B -> A /\ B.
Proof.
  intros A B H.
  apply H.
  intros a b.
  exact (conj a b).
Qed.

(** EXERCICE 2 *)

Lemma and_Church_intro : forall A B : Prop, A -> B -> and_Church A B.
Proof.
  intros A B a b P f.
  exact (f a b).
Qed.

(** EXERCICE 3 — terme pur *)

Lemma and_Church_sym : forall A B : Prop, and_Church A B -> and_Church B A.
Proof.
  exact (fun A B H P f => H P (fun a b => f b a)).
Qed.

(** --- 1.2 : Faux et Vrai de Church --- *)

Definition False_Church : Prop :=
  forall P : Prop, P.

Lemma False_Church_equiv : False <-> False_Church.
Proof.
  split.
  - intros H P. destruct H.
  - intros H. exact (H False).
Qed.

Definition True_Church : Prop :=
  forall P : Prop, P -> P.

Lemma True_Church_equiv : True <-> True_Church.
Proof.
  split.
  - intros _ P p. exact p.
  - intros _. exact I.
Qed.

(** --- 1.3 : Négation de Church --- *)

Definition not_Church (A : Prop) : Prop :=
  A -> False_Church.

Lemma not_Church_equiv : forall A : Prop, ~A <-> not_Church A.
Proof.
  intro A.
  split.
  - intros H a P. exact (False_rect P (H a)).
  - intros H a. exact (H a False).
Qed.

(** --- 1.4 : Existentiel de Church --- *)

Definition exists_Church (T : Type) (P : T -> Prop) : Prop :=
  forall Q : Prop, (forall x : T, P x -> Q) -> Q.

Lemma exists_vers_Church : forall (T : Type) (P : T -> Prop),
    (exists x, P x) -> exists_Church T P.
Proof.
  intros T P H Q f.
  destruct H as [x px].
  exact (f x px).
Qed.

Lemma Church_vers_exists : forall (T : Type) (P : T -> Prop),
    exists_Church T P -> (exists x, P x).
Proof.
  intros T P H.
  apply H.
  intros x px.
  exact (ex_intro P x px).
Qed.

(** ================================================================ *)
(** * PARTIE 2 : Propriétés de l'égalité — λ-termes à la main *)
(** ================================================================ *)

Section Egalite.
Variable T : Type.

Definition eq_sym_terme : forall (x y : T), x = y -> y = x :=
  fun x y H => eq_ind x (fun z => z = x) eq_refl y H.

(** Leibniz — c'est directement eq_ind. *)
Definition leibniz_terme : forall (x y : T) (P : T -> Prop), x = y -> P x -> P y :=
  fun x y P H px => eq_ind x P px y H.

(** EXERCICE 4 *)

(** On applique eq_ind deux fois :
    - d'abord sur H1 : x = x', pour passer de [f x y = f x' y] à ... non.
    On utilise la transitivité :
    f x y = f x' y  (par congruence sur le 1er arg, via H1)
    f x' y = f x' y' (par congruence sur le 2nd arg, via H2)
    puis transitivité.
    Plus directement : deux applications successives de eq_ind. *)
Definition f_equal_2_terme : forall (f : T -> T -> T) (x x' y y' : T),
    x = x' -> y = y' -> f x y = f x' y' :=
  fun f x x' y y' H1 H2 =>
    eq_ind y
      (fun w => f x y = f x' w)
      (eq_ind x (fun z => f x y = f z y) eq_refl x' H1)
      y' H2.

End Egalite.

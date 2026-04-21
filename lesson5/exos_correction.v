(* =========================================================================
   LEÇON 5 : Induction et Programmation Fonctionnelle
   CORRECTION DES EXERCICES
   ========================================================================= *)

Require Import List.
Import ListNotations.

(** ================================================================ *)
(** * PARTIE 1 : Fonctions sur les entiers naturels *)
(** ================================================================ *)

(** EXERCICE 1 : la fonction "est-ce zéro ?"
    Le cas [O] renvoie [true], tout successeur renvoie [false]. *)

Definition is_zero (n : nat) : bool :=
  match n with
  | O   => true
  | S _ => false
  end.

Compute is_zero 0.   (* = true *)
Compute is_zero 3.   (* = false *)

(** EXERCICE 2 : doubler un entier
    On suit le schéma de récursion : [double 0 = 0] et
    [double (S m) = S (S (double m))] (on ajoute 2 à chaque appel récursif,
    conformément à l'équation orientée (m+1) -> m : 2*(m+1) = 2*m + 2). *)

Fixpoint double (n : nat) : nat :=
  match n with
  | O   => O
  | S m => S (S (double m))
  end.

Compute double 0.   (* = 0 *)
Compute double 3.   (* = 6 *)

(** EXERCICE 3 : la multiplication
    On utilise le [+] standard de Rocq. Dans le cas récursif,
    [(S p) * m = (p * m) + m]. *)

Fixpoint mul (n m : nat) : nat :=
  match n with
  | O   => O
  | S p => mul p m + m
  end.

Compute mul 3 4.   (* = 12 *)
Compute mul 0 5.   (* = 0 *)

(** ================================================================ *)
(** * PARTIE 2 : Fonctions sur les listes *)
(** ================================================================ *)

(** EXERCICE 4 : longueur d'une liste
    [[]] a longueur 0 ; [h :: t] a longueur [S (my_length t)]. *)

Fixpoint my_length {A : Type} (l : list A) : nat :=
  match l with
  | []     => 0
  | _ :: t => S (my_length t)
  end.

Compute my_length [1; 2; 3].         (* = 3 *)
Compute my_length ([] : list nat).   (* = 0 *)

(** EXERCICE 5 : inverser une liste
    Pour [h :: t], on inverse récursivement [t], puis on concatène [[h]]
    à droite du résultat. *)

Fixpoint my_rev {A : Type} (l : list A) : list A :=
  match l with
  | []     => []
  | h :: t => my_rev t ++ [h]
  end.

Compute my_rev [1; 2; 3].         (* = [3; 2; 1] *)
Compute my_rev ([] : list nat).   (* = [] *)

(** ================================================================ *)
(** * PARTIE 3 : Preuves par induction *)
(** ================================================================ *)

(** EXERCICE 6 : le successeur commute avec l'addition (à droite).
    Preuve par induction sur [n].
    - Cas [0] : les deux côtés se réduisent à [S m], [reflexivity] conclut.
    - Cas [S p] : après [simpl], le but devient
          [S (p + S m) = S (S (p + m))].
      On réécrit avec l'hypothèse d'induction [IH : p + S m = S (p + m)]
      pour transformer le membre gauche, puis [reflexivity]. *)

Lemma add_succ_r : forall n m : nat, n + S m = S (n + m).
Proof.
  intros n m.
  induction n as [| p IH].
  - (* but : 0 + S m = S (0 + m), i.e. S m = S m *)
    reflexivity.
  - (* but : S p + S m = S (S p + m) *)
    simpl.
    rewrite IH.
    reflexivity.
Qed.

(** EXERCICE 7 : l'addition est associative.
    Même schéma : induction sur [n], le cas [0] se résout par
    [reflexivity] (car [0 + x = x] définitionnellement), et le cas
    récursif se conclut en réécrivant avec l'hypothèse d'induction. *)

Lemma add_assoc : forall n m p : nat, (n + m) + p = n + (m + p).
Proof.
  intros n m p.
  induction n as [| k IH].
  - (* but : (0 + m) + p = 0 + (m + p), i.e. m + p = m + p *)
    reflexivity.
  - (* but : (S k + m) + p = S k + (m + p) *)
    simpl.
    rewrite IH.
    reflexivity.
Qed.

(** ================================================================ *)
(** * BONUS : Longueur de la concaténation *)
(** ================================================================ *)

(** La longueur de [l1 ++ l2] est la somme des longueurs.
    Induction sur [l1], exactement comme pour les entiers. *)

Lemma length_app : forall (A : Type) (l1 l2 : list A),
    my_length (l1 ++ l2) = my_length l1 + my_length l2.
Proof.
  intros A l1 l2.
  induction l1 as [| h t IH].
  - (* but : my_length ([] ++ l2) = my_length [] + my_length l2 *)
    reflexivity.
  - (* but : my_length ((h :: t) ++ l2) = my_length (h :: t) + my_length l2 *)
    simpl.
    rewrite IH.
    reflexivity.
Qed.

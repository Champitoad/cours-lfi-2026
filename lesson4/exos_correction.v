(* =========================================================================
   LEÇON 4 : Proof-theoretic semantics, vérificationnisme et pragmatisme
   CORRECTION DES EXERCICES
   ========================================================================= *)

Section Lesson4_Correction.

Variables A B C : Prop.

(** ================================================================ *)
(** * PARTIE 1 : Éliminateurs à la main (match ... with) *)
(** ================================================================ *)

(** EXERCICE 1 : Extraction de la deuxième composante.
    On filtre [H : A /\ B] avec [match]. L'unique constructeur [conj]
    lie deux variables [a : A] et [b : B] ; on renvoie [b]. *)

Lemma and_elim_2 : A /\ B -> B.
Proof.
  intro H.
  exact (match H with
         | conj a b => b
         end).
Qed.

(** EXERCICE 2 : Symétrie de la disjonction.
    On filtre [H : A \/ B] par ses deux constructeurs. Dans la branche
    [or_introl a], on a [a : A] et on doit produire une preuve de [B \/ A] ;
    on injecte donc à droite avec [or_intror a]. Symétriquement, dans la
    branche [or_intror b], on injecte à gauche avec [or_introl b]. *)

Lemma or_sym : A \/ B -> B \/ A.
Proof.
  intro H.
  exact (match H with
         | or_introl a => or_intror a
         | or_intror b => or_introl b
         end).
Qed.

(** EXERCICE 3 : De la conjonction vers la disjonction.
    Ici on combine les deux gestes : extraire [a : A] de [A /\ B] avec
    [match ... | conj a _ => ...], puis injecter à gauche avec [or_introl a]
    pour former [A \/ C]. L'underscore [_] indique qu'on ignore la composante
    [B] de la paire (on n'en aura pas besoin). *)

Definition and_to_or : A /\ B -> A \/ C :=
  fun H => match H with
           | conj a _ => or_introl a
           end.

(** ================================================================ *)
(** * PARTIE 2 : Propriétés de l'égalité *)
(** ================================================================ *)

Variable T : Type.

(** EXERCICE 4 : Transitivité
    Rappel : [eq_ind : forall (A : Type) (x : A) (P : A -> Prop),
                       P x -> forall y : A, x = y -> P y].

    On veut prouver [x = z] sachant [H1 : x = y] et [H2 : y = z].
    Stratégie : on choisit [P := fun w => x = w], de sorte que :
    - [P y] se réduit en [x = y], prouvé par [H1] ;
    - [P z] se réduit en [x = z], le but.
    On applique donc [eq_ind y P H1 z H2], qui nous donne bien [P z]. *)

Definition eq_trans : forall (x y z : T), x = y -> y = z -> x = z :=
  fun x y z H1 H2 => eq_ind y (fun w => x = w) H1 z H2.

(** EXERCICE 5 : Congruence
    On veut prouver [f x = f y] sachant [H : x = y].
    Stratégie : on choisit [P := fun w => f x = f w], de sorte que :
    - [P x] se réduit en [f x = f x], prouvé par [eq_refl] ;
    - [P y] se réduit en [f x = f y], le but.
    On applique donc [eq_ind x P eq_refl y H]. *)

Definition f_equal : forall (f : T -> T) (x y : T), x = y -> f x = f y :=
  fun f x y H => eq_ind x (fun w => f x = f w) eq_refl y H.

End Lesson4_Correction.

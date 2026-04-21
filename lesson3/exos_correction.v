(* =========================================================================
   LEÇON 3 : Logique du Premier Ordre et Égalité
   CORRECTION DES EXERCICES
   ========================================================================= *)

Section Lesson3_Correction.

Variable T : Type.
Variable P Q : T -> Prop.
Variable R : T -> T -> Prop.

(** EXERCICE 1 : Transitivité de l'égalité.
    Stratégie : réécrire avec la première égalité pour transformer [x = z]
    en [y = z], puis appliquer la seconde. *)

Lemma egalite_trans : forall x y z : T, x = y -> y = z -> x = z.
Proof.
  intros x y z H_xy H_yz.
  (** On réécrit [x] en [y] dans le but [x = z]. *)
  rewrite H_xy.
  (** Le but devient [y = z], que l'on conclut directement. *)
  exact H_yz.
Qed.

(** EXERCICE 2 : Raisonnement équationnel usuel.
    On utilise [rewrite] pour substituer [y] par [z] dans le prédicat [R x y],
    obtenant ainsi [R x z]. *)

Lemma equation_exemple : forall x y z : T,
  R x y -> y = z -> R x z.
Proof.
  intros x y z H_Rxy H_yz.
  (** On réécrit [y] en [z] dans le but [R x z]. Attention : par défaut,
      [rewrite H_yz] substitue le membre gauche [y] par le membre droit [z]
      partout dans le but. *)
  rewrite <- H_yz.
  (** Le but est devenu [R x y], exactement notre hypothèse. *)
  exact H_Rxy.
Qed.

(** REMARQUE : On aurait aussi pu réécrire dans l'hypothèse plutôt que dans
    le but, avec la syntaxe [rewrite H_yz in H_Rxy]. La preuve devient :
<<
      intros x y z H_Rxy H_yz.
      rewrite H_yz in H_Rxy.
      exact H_Rxy.
>>
    C'est une question de goût et de lisibilité. *)

End Lesson3_Correction.

(* =========================================================================
   LEÇON 2 : Logique Propositionnelle et Constructivisme
   CORRECTION DES EXERCICES
   ========================================================================= *)

Section Lesson2_Correction.

Variables A B C : Prop.

(** Rappelons l'axiome du Tiers-Exclu pour la logique classique. *)
Axiom LEM : forall X : Prop, X \/ ~X.

(** EXERCICE 1 : Lois de De Morgan (Sens Intuitionniste) 
    Énoncé : (A \/ B) -> ~(~A /\ ~B)
    Ce sens est constructif car il ne nécessite pas de "choisir" arbitrairement 
    la vérité de A ou B sans information. *)

Lemma de_morgan_1 : (A \/ B) -> ~(~A /\ ~B).
Proof.
  (** [intros] nous donne [H1 : A \/ B] et [H2 : ~A /\ ~B].
      Notre but est donc de prouver [False]. *)
  intros H1 H2.

  (** Commençons par casse la paire [H2] (la conjonction) pour 
      récupérer les deux réfutations [non_a] et [non_b]. *)
  destruct H2 as [non_a non_b].

  (** Maintenant, bifurquons selon les deux cas possibles de [H1]. *)
  destruct H1 as [a | b].

  - (** Cas 1 : On a une preuve [a] de A. Mais on a aussi [non_a] qui dit que 
       A implique l'absurde. Conclusion immédiate. *)
    apply non_a. exact a.

  - (** Cas 2 : On a une preuve [b] de B. Idem avec [non_b]. *)
    apply non_b. exact b.
Qed.

(** EXERCICE 2 : Lois de De Morgan (Sens Classique)
    Enoncé : ~(~A /\ ~B) -> (A \/ B)
    Ce sens est célèbre car il est "paralysé" en logique purement intuitionniste.
    Sans le Tiers-Exclu, nous ne savons pas si c'est A ou B qui est vrai (ou les deux),
    et nous ne pouvons pas non plus les réfuter directement. *)

Lemma de_morgan_2 : ~(~A /\ ~B) -> (A \/ B).
Proof.
  intros H.

  (** Pour débloquer la situation, nous pouvons faire un raisonnement par l'absurde
      "déguisé" en utilisant le Tiers-Exclu sur A. *)
  destruct (LEM A) as [a | non_a].

  - (** Si A est vrai (par magie du LEM), alors le but [A \/ B] est trivialement 
        vrai par injection gauche. *)
    left. exact a.

  - (** Si A est faux, nous ne savons toujours rien sur B. Utilisons à nouveau 
        le LEM sur B ! *)
    destruct (LEM B) as [b | non_b].

    + (** Si B est vrai, le but [A \/ B] est vrai par injection droite. *)
      right. exact b.

    + (** Si A et B sont TOUS LES DEUX faux ([non_a] et [non_b]), alors nous 
          pouvons construire la paire [(non_a, non_b)] qui contredit frontalement 
          notre hypothèse de départ [H]. *)
      exfalso.
      apply H.
      split.
      * exact non_a.
      * exact non_b.
Qed.

End Lesson2_Correction.

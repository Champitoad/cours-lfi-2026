(** * LEÇON 4 : Proof-theoretic semantics, vérificationnisme et pragmatisme *)

(** Nous avons vu aujourd'hui que les connecteurs logiques sont définis dans Rocq
    comme des types inductifs, dont les constructeurs sont exactement les règles
    d'introduction de la déduction naturelle.

    La tactique [destruct] génère automatiquement un [match ... with ... end]
    pour éliminer ces constructeurs. Dans ces exercices, vous allez d'abord
    écrire ce [match] vous-mêmes, à la main, pour bien voir ce qui se passe
    sous le capot. Vous décortiquerez ensuite les propriétés fondamentales de
    l'égalité, dont le comportement est lui aussi justifié par la sémantique
    vérificationniste. *)

Axiom todo : forall {X : Prop}, X.

Section Lesson4.

Variables A B C : Prop.

(** ================================================================ *)
(** * PARTIE 1 : Éliminateurs à la main (match ... with) *)
(** ================================================================ *)

(** Rappel : le type [A /\ B] a un seul constructeur [conj : A -> B -> A /\ B].
    Pour *utiliser* une hypothèse [H : A /\ B], on filtre par motif :
      [match H with | conj a b => ... end]
    où [a : A] et [b : B] sont les deux composantes extraites.

    Le type [A \/ B] a deux constructeurs : [or_introl : A -> A \/ B]
    et [or_intror : B -> A \/ B]. Le filtrage génère deux branches :
      [match H with | or_introl a => ... | or_intror b => ... end] *)

(** EXEMPLE : Symétrie de la conjonction — à l'aide de [match].
    On extrait les composantes de [H : A /\ B] avec [match],
    puis on reconstruit dans l'ordre inverse avec [conj]. *)
Lemma and_sym : A /\ B -> B /\ A.
Proof.
  intro H.
  exact (match H with
         | conj a b => conj b a
         end).
Qed.

(** EXERCICE 1 : Extraction de la deuxième composante.
    Consigne : Utilisez [match] explicitement (pas [destruct]). *)
Lemma and_elim_2 : A /\ B -> B.
Proof.
  (* À COMPLÉTER *)
Admitted.

(** EXERCICE 2 : Symétrie de la disjonction — à l'aide de [match].
    Consigne : N'utilisez pas [destruct]. Le [match] doit avoir deux branches,
    une pour [or_introl] et une pour [or_intror], et chacune doit réinjecter
    de l'autre côté. *)
Lemma or_sym : A \/ B -> B \/ A.
Proof.
  intro H.
  (** Indice : votre terme sera de la forme
        [match H with | or_introl a => ... | or_intror b => ... end]
      où chaque branche utilise [or_intror] ou [or_introl] pour changer de côté. *)
  (* À COMPLÉTER *)
Admitted.

(** EXERCICE 3 : De la conjonction vers la disjonction.
    Consigne : Utilisez [match] pour extraire [A] de [A /\ B], puis
    construire une injection [or_introl] pour produire [A \/ C]. *)
Definition and_to_or : A /\ B -> A \/ C :=
  todo. (* À COMPLÉTER *)

(** ================================================================ *)
(** * PARTIE 2 : Propriétés de l'égalité *)
(** ================================================================ *)

Variable T : Type.

(** Rappel : [eq_ind] est l'éliminateur de [eq] dérivé automatiquement par Rocq.
      [eq_ind : forall (A : Type) (x : A) (P : A -> Prop),
                P x -> forall y : A, x = y -> P y]

    Stratégie : pour prouver [Q y] sachant [H : x = y], choisir [P := fun z => Q z]
    de sorte que [P x] se réduit en [Q x], puis écrire [eq_ind x P (preuve de Q x) y H].

    EXEMPLE (vu dans cours.v) — symétrie :
    Choisir [P := fun z => z = x], de sorte que [P x] se réduit en [x = x],
    prouvé par [eq_refl] *)

Definition eq_symm : forall (x y : T), x = y -> y = x :=
  fun x y H => eq_ind x (fun z => z = x) eq_refl y H.

(** EXERCICE 4 : Transitivité
    Pour prouver [x = z] sachant [H1 : x = y] et [H2 : y = z].
    Indice : choisir [P := fun w => x = w]. *)
Definition eq_trans : forall (x y z : T), x = y -> y = z -> x = z :=
  todo. (* À COMPLÉTER *)

(** EXERCICE 5 : Congruence
    Si [x = y], alors [f x = f y] pour toute [f : T -> T]. *)
Definition f_equal : forall (f : T -> T) (x y : T), x = y -> f x = f y :=
  todo. (* À COMPLÉTER *)

(** ================================================================ *)
(** * PARTIE 3 : Expérimenter avec Compute *)
(** ================================================================ *)

(** [Compute] évalue une expression jusqu'à sa forme normale.
    Observez comment chaque introducteur immédiatement suivi de son éliminateur
    se réduit — c'est l'élimination des détours (cut elimination). *)

Variable (a : A) (b : B) (f : A -> C) (g : B -> C).

(** Détour fonctionnel (β) : *)
Compute (fun x : A => x) a.

(** Détour conjonctif : *)
Compute (match conj a b with conj x y => x end).

(** Détour disjonctif : *)
Compute (match or_introl a : A \/ B with
         | or_introl x => f x
         | or_intror y => g y
         end).

(** Question : que se passe-t-il si vous remplacez [or_introl a] par [or_intror b] ?
    Essayez d'abord de deviner la réponse mentalement avant de "tricher" avec [Compute] ! *)

(** Question bonus : construisez un exemple de "double détour"
    (deux introductions suivies de deux éliminations) et vérifiez
    avec [Compute] la valeur finale donnée par la normalisation.

    Vous pourrez procéder en suivant ces étapes :
    1. commencez par expérimenter sur papier en déduction naturelle,
       en combinant différentes règles pour obtenir une dérivation
       qui a la bonne structure (peut contenir des prémisses ouvertes)
    2. découvrez son contenu calculatoire en suivant le "dictionnaire"
       Curry-Howard pour ajouter les annotations de termes (slides de la Leçon 2)
    3. traduisez en un terme de preuve Rocq à l'aide de la Cheatsheet *)

End Lesson4.
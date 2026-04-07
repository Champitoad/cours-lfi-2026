(** Exercices Bonus — Leçon 4 *)
(** Ces exercices approfondissent deux thèmes du cours :
    1. L'étude complète des encodages de Church (perspective pragmatiste)
    2. La construction à la main de λ-termes pour les propriétés de l'égalité,
       en invoquant [eq_ind] directement sans tactique [rewrite]. *)

(** ================================================================ *)
(** * PARTIE 1 : Les encodages de Church — étude complète *)
(** ================================================================ *)

(** Rappel : un encodage de Church définit un connecteur logique
    UNIQUEMENT à partir de son éliminateur — sans type inductif.
    La clé : une preuve de [X_Church] est une fonction qui, pour toute
    conclusion [P], sait produire [P] en utilisant les hypothèses attendues.

    Nous avons vu en cours l'encodage de [A \/ B].
    Étudions maintenant tous les autres connecteurs. *)

(** --- 1.1 : Conjonction de Church --- *)

(** L'éliminateur de [A /\ B] permet de produire [P]
    à partir d'une fonction qui consomme [A] et [B] simultanément. *)
Definition and_Church (A B : Prop) : Prop :=
  forall P : Prop, (A -> B -> P) -> P.

(** EXERCICE 1 : Équivalence avec [A /\ B].
    Direction "vers Church" : déstruire la paire et passer les composantes
    à la continuation.
    Direction "depuis Church" : instancier [P := A /\ B] et choisir
    [conj] comme continuation. *)
Lemma and_vers_Church : forall A B : Prop, A /\ B -> and_Church A B.
Proof.
  (* À COMPLÉTER *)
Admitted.

Lemma Church_vers_and : forall A B : Prop, and_Church A B -> A /\ B.
Proof.
  (* À COMPLÉTER *)
Admitted.

(** EXERCICE 2 : Dérivez les introductions de [and_Church].
    C'est la démarche pragmatiste : les règles d'introduction se DÉDUISENT
    des éliminations. Ici, vous ne pouvez utiliser ni [split] ni [conj].
    Indice : [and_Church A B P f] produit [P] si [f : A -> B -> P].
    Construire une telle [f] à partir de [a : A] et [b : B] est immédiat. *)
Lemma and_Church_intro : forall A B : Prop, A -> B -> and_Church A B.
Proof.
  (* À COMPLÉTER *)
Admitted.

(** EXERCICE 3 : Symétrie de [and_Church] — en mode terme pur.
    Ne pas utiliser de tactiques. Votre terme aura la structure :
      [fun A B H P f => H P (fun a b => ...)]
    où vous devez trouver comment réordonner [a] et [b] pour satisfaire [f]. *)
Lemma and_Church_sym : forall A B : Prop, and_Church A B -> and_Church B A.
Proof.
  (* À COMPLÉTER *)
Admitted.

(** --- 1.2 : Faux et Vrai de Church --- *)

(** L'encodage de [False] : de [False] on peut dériver n'importe quoi.
    L'éliminateur de [False] EST sa définition à la Church. *)
Definition False_Church : Prop :=
  forall P : Prop, P.

Lemma False_Church_equiv : False <-> False_Church.
Proof.
  (* À COMPLÉTER *)
Admitted.

(** L'encodage de [True] : [True] possède une seule preuve triviale.
    Son éliminateur peut simplement renvoyer ce qu'on lui donne. *)
Definition True_Church : Prop :=
  forall P : Prop, P -> P.

Lemma True_Church_equiv : True <-> True_Church.
Proof.
  (* À COMPLÉTER *)
Admitted.

(** --- 1.3 : Négation de Church --- *)

(** La négation [~A] est [A -> False] dans Rocq.
    Son encodage à la Church en découle naturellement : *)
Definition not_Church (A : Prop) : Prop :=
  A -> False_Church.

Lemma not_Church_equiv : forall A : Prop, ~A <-> not_Church A.
Proof.
  (* À COMPLÉTER *)
Admitted.

(** --- 1.4 : Existentiel de Church --- *)

(** L'éliminateur de [exists x : T, P x] : pour produire [Q], il suffit de
    savoir produire [Q] à partir de n'importe quel témoin [x] vérifiant [P x]. *)
Definition exists_Church (T : Type) (P : T -> Prop) : Prop :=
  forall Q : Prop, (forall x : T, P x -> Q) -> Q.

Lemma exists_vers_Church : forall (T : Type) (P : T -> Prop),
    (exists x, P x) -> exists_Church T P.
Proof.
  (* À COMPLÉTER *)
Admitted.

Lemma Church_vers_exists : forall (T : Type) (P : T -> Prop),
    exists_Church T P -> (exists x, P x).
Proof.
  (* Indice : instanciez [Q := exists x, P x] dans [exists_Church]. *)
  (* À COMPLÉTER *)
Admitted.

(** ================================================================ *)
(** * PARTIE 2 : Propriétés de l'égalité — λ-termes à la main *)
(** ================================================================ *)

(** Rappel : l'éliminateur de [eq] est [eq_ind].
      [eq_ind : forall (A : Type) (x : A) (P : A -> Prop),
                P x -> forall y : A, x = y -> P y]

    Stratégie générale pour prouver [Q y] sachant [H : x = y] :
    choisir [P := fun z => Q z], de sorte que [P x = Q x],
    puis appliquer [eq_ind x P (preuve de Q x) y H].

    On utilise [Definition] pour les termes complets,
    et [Lemma + Admitted] pour les exercices à compléter. *)

Section Egalite.
Variable T : Type.

(** EXEMPLE : Symétrie (vu en cours).
    [P := fun z => z = x], de sorte que [P x = (x = x)], prouvé par [eq_refl]. *)
Definition eq_sym_terme : forall (x y : T), x = y -> y = x :=
  fun x y H => eq_ind x (fun z => z = x) eq_refl y H.

(** EXEMPLE : Leibniz — c'est directement [eq_ind].
    [P := fun z => Q z], la preuve de [Q x] est [px], et [H : x = y]. *)
Definition leibniz_terme : forall (x y : T) (P : T -> Prop), x = y -> P x -> P y :=
  fun x y P H px => eq_ind x P px y H.

(** EXERCICE 4 (difficile) : Double congruence.
    Si [x = x'] et [y = y'], montrer [f x y = f x' y'] pour [f : T -> T -> T].
    Indice : utilisez [eq_ind] deux fois de suite, en choisissant soigneusement
    [P] à chaque étape. Vous pouvez aussi combiner la transitivité et la congruence
    simple (Exercice 5 des exercices principaux). *)
Lemma f_equal_2_terme : forall (f : T -> T -> T) (x x' y y' : T),
    x = x' -> y = y' -> f x y = f x' y'.
Proof.
  (* À COMPLÉTER *)
Admitted.

End Egalite.

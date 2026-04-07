(** Script d'accompagnement — Live Coding Leçon 4 *)
(** Ces exemples accompagnent directement la présentation Beamer.
    Copiez ce fichier dans jsCoq et exécutez les commandes une à une. *)

(** ================================================================ *)
(** * PARTIE 1 : Les types inductifs sous le capot *)
(** ================================================================ *)

(** La bibliothèque standard définit [and], [or] et [eq] comme des
    types inductifs à la manière vérificationniste : les constructeurs
    sont exactement les règles d'INTRODUCTION de la déduction naturelle.
    Vérifions-le directement. *)

Print and.
(** Résultat :
      Inductive and (A B : Prop) : Prop :=
        conj : A -> B -> A /\ B          <- règle /\I *)

Check or_ind.

Definition or_prag (A B : Prop) : Prop := forall (P : Prop), (A -> P) -> (B -> P) -> A \/ B -> P.


Lemma or_intro1 (A B : Prop) : A -> or_prag A B.
Proof.
  intros x.
  unfold or_prag.
  intros P D1 D2 D.
  destruct D as [H1 | H2].
  - apply D1. exact H1.
  - apply D2. exact H2.
Qed.

Print or.
(** Résultat :
      Inductive or (A B : Prop) : Prop :=
        or_introl : A -> A \/ B          <- règle \/I₁
      | or_intror : B -> A \/ B          <- règle \/I₂ *)

Print eq.
Check eq_ind.
(** Résultat :
      Inductive eq (A : Type) (x : A) : A -> Prop :=
        eq_refl : x = x                  <- l'unique règle d'intro de = *)

(** Remarques clés :
    - [conj], [or_introl], [or_intror], [eq_refl] sont les constructeurs
      invoqués par [split], [left]/[right], [reflexivity].
    - Il n'existe aucun autre moyen de construire ces preuves.
    - Pour [eq] : [x = y] n'est habité que si [x] et [y] sont
      définitionnellement le même terme. *)

(** ================================================================ *)
(** * PARTIE 2 : match ... with — l'éliminateur à la main *)
(** ================================================================ *)

(** La tactique [destruct] génère automatiquement un pattern-matching
    ou "filtrage par motif" ([match ... with ... end]).
    Regardons le terme de preuve réel, en l'écrivant directement. *)

Section Partie2.

Variables T : Type.
Variables A B C : Prop.

(** --- Élimination de [A /\ B] --- *)

(** Version tactique (style habituel) : *)
Lemma and_elim_1_tac : A /\ B -> A.
Proof.
  intros H.
  destruct H as [a b].
  exact a.
Qed.

(** Version terme pur (Gallina) — en utilisant [match] explicitement : *)
Definition and_elim_1_terme : A /\ B -> A :=
  fun H => match H with
           | conj a b => a
           end.

(** Les deux programmes sont identiques : [destruct] n'est qu'un raccourci. *)
Print and_elim_1_tac.
Print and_elim_1_terme.

(** --- Élimination de [A \/ B] — raisonnement par cas --- *)

(** Version terme pur : *)
Definition or_elim_terme : A \/ B -> (A -> C) -> (B -> C) -> C :=
  fun H f g => match H with
               | or_introl a => f a
               | or_intror b => g b
               end.

(** Observez : ce terme EST la règle d'élimination de la disjonction
    en déduction naturelle, traduite en programme. *)

End Partie2.

(** ================================================================ *)
(** * INTERLUDE : Compute — l'élimination des détours en action *)
(** ================================================================ *)

(** [Compute] évalue une expression jusqu'à sa forme normale.
    Un "détour" = un introducteur immédiatement suivi de son éliminateur.
    La normalisation prédit qu'ils peuvent TOUJOURS être éliminés. *)

Section Interlude.

Variable (A B C : Prop) (a : A) (b : B) (f : A -> C) (g : B -> C).

(** 1. Détour fonctionnel (β) : [(fun x => M) N  ↝  M[N/x]] *)
Compute (fun x : A => x) a.
(** = a *)

(** 2. Détour conjonctif : [match (conj a b) with conj x y => x end  ↝  a] *)
Compute (match conj a b with conj x y => x end).
(** = a — la composante [b] est ignorée *)

(** 3. Détour disjonctif : [match (or_introl a) with or_introl x => f x | ...  ↝  f a] *)
Compute (match or_introl a : A \/ B with
         | or_introl x => f x
         | or_intror y => g y
         end).
(** = f a — la branche [or_intror] est morte, jamais exécutée *)

End Interlude.

(** ================================================================ *)
(** * PARTIE 3 : Les encodages de Church (le point de vue pragmatiste) *)
(** ================================================================ *)

(** Dans le Calcul des Constructions pur (sans [Inductive]),
    on peut définir les connecteurs directement à partir de leurs éliminateurs.

    Le pragmatisme : le sens de [A \/ B] = ce qu'on peut en faire.
    Ce qu'on peut faire de [A \/ B], c'est exactement la règle d'élimination :
    pour toute conclusion [P], si on sait dériver [P] de [A] et [P] de [B],
    alors on conclut [P]. D'où l'encodage : *)

Definition or_Church (A B : Prop) : Prop :=
  forall P : Prop, (A -> P) -> (B -> P) -> P.

(** Cet encodage est LOGIQUEMENT ÉQUIVALENT au type inductif [A \/ B] : *)

Lemma or_vers_Church : forall A B : Prop, A \/ B -> or_Church A B.
Proof.
  intros A B H P f g.
  destruct H as [a | b].
  - exact (f a).
  - exact (g b).
Qed.

Lemma Church_vers_or : forall A B : Prop, or_Church A B -> A \/ B.
Proof.
  intros A B H.
  apply H.
  - intro a. left.  exact a.
  - intro b. right. exact b.
Qed.

(** --- Pourquoi Rocq choisit [Inductive] et non Church ? ---

    Une preuve de [or_Church A B] est une FONCTION (un terme).
    Pour en extraire de l'information, il faut une beta-réduction.
    Pire : les structures de données encodées à la Church (listes, entiers...)
    sont entièrement constituées de fonctions imbriquées, ce qui les rend
    impraticables à grande échelle.

    Avec [Inductive], une preuve de [A \/ B] est une DONNÉE CONCRÈTE
    (une injection [or_introl a] ou [or_intror b]), directement inspectable
    par pattern-matching, et compilable en code machine efficace.

    L'ironie : Rocq choisit le vérificationnisme pour des raisons pragmatiques ! *)

(** ================================================================ *)
(** * PARTIE 4 : L'éliminateur de l'égalité = le principe de Leibniz *)
(** ================================================================ *)

Section Partie4.

Variables T : Prop.

(** [eq] possède un seul constructeur ([eq_refl]).
    Rocq dérive automatiquement son éliminateur, appelé [eq_ind].
    Regardons sa signature : *)

Check @eq_ind.
(** Résultat :
      eq_ind :
        forall (A : Type) (x : A) (P : A -> Prop),
        P x -> forall y : A, x = y -> P y

    Lu en français : si [P] est vraie pour [x], et si [x = y],
    alors [P] est vraie pour [y].

    C'est exactement le PRINCIPE DE LEIBNIZ :
    "si x et y sont identiques, toute propriété de x est propriété de y".

    La tactique [rewrite H] (pour [H : x = y]) applique silencieusement
    [eq_ind] dans les coulisses. *)

(** Démonstration : prouvons la symétrie de [=] de deux façons. *)

(** Version tactique (style habituel) : *)
Lemma eq_sym_tac : forall (x y : T), x = y -> y = x.
Proof.
  intros x y H.
  rewrite H.    (* <- applique eq_ind sous le capot *)
  reflexivity.
Qed.

(** Version terme pur — on invoque [eq_ind] directement.
    Stratégie : on veut montrer [y = x] sachant [H : x = y].
    On choisit [P := fun z => z = x], de sorte que [P x] se β-réduit en [x = x]].
    Alors [eq_ind] transforme [eq_refl : x = x] en une preuve de [y = x]. *)
Definition eq_sym_terme : forall (x y : T), x = y -> y = x :=
  fun x y H => eq_ind x (fun z => z = x) eq_refl y H.

Print eq_sym_tac.
Print eq_sym_terme.

Check eq_ind.
Check eq_ind_r.

End Partie4.
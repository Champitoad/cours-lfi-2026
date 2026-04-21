Require Import List.
Import ListNotations.

(** * Exercice 1 *)

Lemma app_nil_r : forall (A : Type) (l : list A),
    l ++ [] = l.
Proof.
Admitted.

(** * Exercice 2 *)

Lemma app_assoc : forall (A : Type) (l1 l2 l3 : list A),
    (l1 ++ l2) ++ l3 = l1 ++ (l2 ++ l3).
Proof.
Admitted.

(** * Exercice 3 *)
(** Vous aurez besoin des exercices 1 et 2. *)

Lemma rev_app : forall (A : Type) (l1 l2 : list A),
    rev (l1 ++ l2) = rev l2 ++ rev l1.
Proof.
Admitted.

(** * Exercice 4 *)
(** Vous aurez besoin de l'exercice 3. *)

Theorem rev_involutive : forall (A : Type) (l : list A),
    rev (rev l) = l.
Proof.
Admitted.

(** * Questions de compréhension *)

(** Répondez aux questions suivantes en quelques phrases,
    directement ici en commentaires.

    Question 1 :
    Pourquoi ne peut-on pas prouver [rev (rev l) = l] simplement avec
    [reflexivity], sans induction ?

    Réponse :


    Question 2 :
    Quel est le rôle du lemme [rev_app] dans la preuve de
    [rev_involutive] ? Pourquoi est-il nécessaire ?

    Réponse :


    Question 3 :
    Les exercices 1 à 3 sont des lemmes auxiliaires. Aurait-on pu
    s'en passer et tout prouver d'un seul coup dans l'exercice 4 ?
    Quel est l'intérêt de décomposer la preuve en lemmes ?

    Réponse :

*)

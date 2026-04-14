# Plan enseignant — Leçon 5 : Induction et Programmation Fonctionnelle

> **À ne pas montrer aux étudiants.** Ce document est le script de la leçon.
> Objectif : 40 min de présentation (slides + démos), ~50 min d'exercices en autonomie.

---

## Vue d'ensemble

| #   | Mode      | Durée   | Contenu                                             |
| --- | --------- | ------- | --------------------------------------------------- |
| 1   | Slides    | 3 min   | Frames 1–2 : titre + rappel L4                      |
| 2   | jsCoq     | 5 min   | Démo 1 : explorer `nat`                             |
| 3   | Slides    | 5 min   | Frames 3–4 : nat à la Peano + pred                  |
| 4   | jsCoq     | 6 min   | Démo 2 : redéfinir nat, écrire pred                 |
| 5   | Slides    | 9 min   | Frames 5–7 : Fixpoint + Y/point fixe + Curry-Howard |
| 6   | jsCoq     | 5 min   | Démo 3 : Fixpoint add + explication Y               |
| 7   | Slides    | 3 min   | Frame 8 : list + app                                |
| 8   | jsCoq     | 4 min   | Démo 4 : Print list, app                            |
| 9   | Slides    | 8 min   | Frames 8–10 : nat_ind, induction, connexion         |
| 10  | jsCoq     | 7 min   | Démo 5 : Check nat_ind, preuve add_0_r              |
| 11  | Slides    | 3 min   | Frame 11 : synthèse                                 |
| —   | Exercices | ~50 min | exos.v en autonomie                                 |

---

## DÉMO 1 — Explorer nat dans la stdlib (5 min)

→ **Passez sur jsCoq** (fichier vide ou nouveau buffer)

**Tapez :**

```coq
Print nat.
```

**Dites :** « Rocq connaît déjà `nat` dans sa bibliothèque standard. On voit exactement deux constructeurs : `O` et `S`. »

```coq
Check O.
Check S.
Check S (S (S O)).
Compute S (S O).
```

**Demandez aux étudiants :** « Combien de constructeurs a `or` ? » _(Réponse : 2 — `or_introl` et `or_intror`. Même chose ici.)_

→ **Repassez sur les slides — Frame 3**

---

## DÉMO 2 — Redéfinir nat + pred (6 min)

→ **Passez sur jsCoq**

**Tapez :**

```coq
Inductive myNat : Set :=
  | O : nat
  | S : nat -> nat.
```

**Dites :** « On redéfinit `nat` nous-mêmes pour bien voir. Rocq accepte immédiatement. »

```coq
Check myNat_ind.
Check myNat_rec.
```

**Dites :** « Rocq a automatiquement dérivé deux éliminateurs : `myNat_ind` pour les preuves, `myNat_rec` pour les données. On y reviendra. »

```coq
Definition pred (n : nat) : nat :=
  match n with
  | O   => O
  | S m => m
  end.

Compute pred O.
Compute pred (S (S (S O))).
```

**Demandez :** « Quelles branches doit-on avoir dans le `match` ? » _(Laisser répondre : une pour `O`, une pour `S m`.)_

```coq
End MyNat.
```

→ **Repassez sur les slides — Frame 5**

---

## DÉMO 3 — Fixpoint add (5 min)

→ **Passez sur jsCoq**

**Dites :** « Essayons d'écrire l'addition. Avec `Definition`, on ne peut pas s'appeler soi-même. Il faut `Fixpoint`. »

```coq
Fixpoint add (n m : nat) : nat :=
  match n with
  | O   => m
  | S p => S (add p m)
  end.

Compute add 2 3.
```

**Montrez :** l'étape de réduction mentalement ou au tableau : `add (S (S O)) 3 = S (add (S O) 3) = S (S (add O 3)) = S (S 3) = 5`.

**Point important :** « Remarquez qu'on fait la récursion sur `n`, pas sur `m`. À chaque appel, `p` est plus petit que `S p`. Rocq vérifie ça. »

**Expliquez le nom « Fixpoint » :**
« Une définition récursive est un _point fixe_ : écrire `add n m = ... add ...` revient à chercher `add` tel que `add = F add`, où F capture le corps de la définition. En λ-calcul non typé, c'est exactement le rôle du combinateur Y — `Y F` est un point fixe de F par définition. Le mot-clé `Fixpoint` vient de là. »

« Mais Y ne peut pas être un terme ordinaire dans Rocq. Pour le typer, il faudrait admettre l'axiome `(A -> A) -> A`. Or `A -> A` est trivialement habité par `fun x => x` — on obtiendrait donc un habitant de tout type, y compris `False`. Rocq fournit le service de Y via un primitif du noyau qui vérifie la récursion structurelle avant d'accepter la définition. »

_(Démo optionnelle si le temps le permet :)_

```coq
Axiom Y_type : forall A, (A -> A) -> A.
Check Y_type False (fun x => x).  (* : False *)
```

**Montrez l'asymétrie (moment pédagogique clé) :**

```coq
Lemma add_0_l : forall n, add 0 n = n.
Proof. intro n. reflexivity. Qed.
```

**Dites :** « `0 + n = n` est vrai _par définition_ — Rocq le voit immédiatement. Maintenant essayons l'autre sens : »

```coq
Lemma add_0_r_essai : forall n, add n 0 = n.
Proof. intro n. reflexivity. (* ÉCHOUE *) Abort.
```

**Dites :** « `n + 0 = n` ne se réduit pas sans savoir ce qu'est `n`. Il faut raisonner par cas sur `n` — c'est-à-dire, par _induction_. On y revient dans quelques minutes. »

→ **Repassez sur les slides — Frame 7**

---

## DÉMO 4 — list + app (4 min)

→ **Passez sur jsCoq**

```coq
Print list.
```

**Dites :** « Même structure que `nat` : deux constructeurs, `nil` (base) et `cons` (récursif). Mais `cons` prend en plus un élément de type `A`. »

```coq
Fixpoint app {A : Type} (l1 l2 : list A) : list A :=
  match l1 with
  | []     => l2
  | h :: t => h :: (app t l2)
  end.

Compute app [1;2] [3;4].
```

→ **Repassez sur les slides — Frame 8**

---

## DÉMO 5 — nat_ind + preuve add_0_r (7 min)

→ **Passez sur jsCoq**

```coq
Check nat_ind.
```

**Lisez** le type à voix haute : « Pour toute propriété `P` sur `nat` : si `P O` est vraie, et si pour tout `p`, `P p` implique `P (S p)`, alors `P n` est vraie pour tout `n`. C'est le principe d'induction mathématique. »

```coq
Check list_ind.
```

**Dites :** « Même chose pour les listes — dérivé automatiquement. »

```coq
Lemma add_0_r : forall n : nat, n + 0 = n.
Proof.
  intro n.
  induction n as [| p IH].
```

**Arrêtez ici.** Montrez les deux sous-buts dans le panneau. **Demandez :** « Quel est le premier sous-but ? » _(O + 0 = O)_ « Le deuxième ? » _(S p + 0 = S p, avec IH : p + 0 = p)_

```coq
  - reflexivity.
  - simpl. rewrite IH. reflexivity.
Qed.
```

**Après `simpl`, expliquez :** « `simpl` a déplié la définition de `+` et transformé `S p + 0` en `S (p + 0)`. »
**Après `rewrite IH` :** « On remplace `p + 0` par `p` grâce à l'hypothèse d'induction. »

→ **Repassez sur les slides — Frames 9–11**

---

## Notes générales

- **Étudiants sans expérience en programmation :** à la Démo 3, tracer `add 2 3` pas à pas est essentiel. Leur demander d'anticiper chaque étape.
- **Si avance** : montrer `Check nat_rec.` et dire « c'est ce que `Fixpoint` utilise sous le capot — `nat_ind` et `nat_rec` sont le même éliminateur dans deux univers différents ».
- **Si retard** : supprimer le `Lemma add_0_l` / `add_0_r_essai` de la Démo 3, aller directement à la Démo 5.
- **Transition vers les exercices :** « Vous allez maintenant définir vos propres fonctions et prouver des propriétés. Les exercices sont guidés — lisez bien les commentaires. »

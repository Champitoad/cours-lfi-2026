# Notes pour la discussion avec Alberto — Evaluations

> Document de travail, résumé du brainstorm du 16 avril 2026.
> A discuter lors de la réunion du mardi 21 avril.

---

## 1. Devoir maison (DM) — Partie assistants de preuve

**Contexte :** Les étudiants ont déjà un DM sur le lambda-calcul (sujet donné le 14 avril). Ce second DM couvre la partie Rocq (leçons 1-6). Deadline sujet : vendredi 25 avril au plus tard.

### Format proposé

- **Exercices Coq guidés** autour de la preuve de `rev (rev l) = l`, mobilisant les notions vues en cours (induction, lemmes auxiliaires, réécriture).
- **Questions de compréhension** en français (rôle des lemmes, pourquoi `reflexivity` ne suffit pas, etc.).
- **Coefficient modeste** — le DM est un exercice d'apprentissage plus qu'une évaluation fiable, étant donné qu'un LLM peut produire les réponses (code Coq et explications en français).

### Limites face à l'IA

Aucun format de DM à la maison n'est véritablement résistant à un LLM de niveau Opus. L'approche retenue : accepter cette réalité, garder un coefficient faible, et considérer le DM comme une occasion d'apprentissage (même un étudiant qui utilise l'IA apprend en lisant la réponse).

**Piste complémentaire (si faisable) :** soutenance rapide (2-3 min par étudiant, en présentiel ou en visio) pour vérifier la compréhension. A évaluer en termes de faisabilité logistique.

---

## 2. Examen sur table

**Contrainte :** pas de salle informatique disponible — tout se fait sur papier.

### Formats d'exercices envisagés

#### a) Prédire l'état de preuve (recommandé)

Donner un lemme et un script de preuve tactique par tactique. Les étudiants écrivent les hypothèses et la conclusion après chaque étape.

- Teste directement la compréhension de l'effet des tactiques.
- Se corrige facilement.
- Faisable avec un cheatsheet imprimé (syntaxe + description des tactiques).
- Rester sur des exemples simples (logique propositionnelle, petites inductions sur `nat`).

#### b) Termes de preuve (habiter un type)

Donner un type/proposition et demander d'écrire le lambda-terme qui l'habite.

- Exemple : « Ecrivez un terme de type `A /\ B -> B /\ A`. »
- Plus facile sur papier que les tactiques (pas d'état interactif à simuler).
- Fait le pont avec la partie lambda-calcul d'Alberto.

#### c) Traduction lambda-calcul <-> Rocq <-> déduction naturelle

Exercices de traduction entre les trois formalismes :

- Donner un arbre de déduction naturelle, demander le terme Rocq correspondant (ou inversement).
- Donner un script de tactiques, demander le lambda-terme généré (ou inversement).
- Donner un lambda-terme, demander l'arbre de déduction naturelle.

C'est l'exercice qui teste le mieux la compréhension de Curry-Howard : les tactiques génèrent des lambda-termes, qui correspondent à des arbres de déduction naturelle. Les trois formalismes disent la même chose.

**Important :** rester sur des exemples de logique propositionnelle simple (implications, conjonctions, disjonctions). Pas d'induction ni de quantificateurs pour cet exercice.

#### d) Lambda-calcul pur

Exercices relevant de la partie d'Alberto (réductions, typage, etc.).

---

## 3. Points à trancher avec Alberto

- [ ] Coefficient du DM Rocq par rapport au DM lambda-calcul et à l'examen
- [ ] Faisabilité des soutenances (présentiel/visio)
- [ ] Répartition des exercices de l'examen entre lambda-calcul et Rocq
- [ ] Niveau de difficulté des exercices de traduction (quels connecteurs, quelle complexité)
- [ ] Cheatsheet à fournir : contenu exact, format (recto-verso A4 ?)

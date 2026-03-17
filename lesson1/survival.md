# 🛟 Le Guide de Survie jsCoq : Leçon 1

Bienvenue dans la démonstration interactive de théorèmes ! Rocq est une machine hyper-pédante : elle ne vous laissera sauter aucune étape et exige une précision parfaite. Ne paniquez pas si elle vous crie dessus en texte rouge — c'est simplement la machine qui vous demande des éclaircissements.

## 1. L'Interface : Qu'est-ce que je regarde ?
Lorsque vous avancez dans une preuve sur jsCoq, votre écran se divise en deux zones principales :
- **Le Panneau Gauche (L'Éditeur) :** C'est ici que vous écrivez votre code et vos tactiques.
- **Le Panneau Droit (L'État / The State) :** C'est votre "brouillon" et la partie la plus importante de l'écran. Il est divisé par une ligne horizontale `====` :
    - **Au-dessus de la ligne (Le Contexte) :** Ce que vous savez ou supposez actuellement (vos hypothèses et variables).
    - **En dessous de la ligne (Le But / The Goal) :** Ce que vous devez actuellement prouver.

## 2. Navigation : Comment parler à la machine ?
Rocq lit votre fichier phrase par phrase.
- **La Règle d'Or :** CHAQUE commande ou tactique DOIT se terminer par un point `.`. Si vous obtenez une erreur de syntaxe étrange, vérifiez si vous n'avez pas oublié le point à la ligne précédente !
- **Avancer (Step Forward) :** Appuyez sur `Alt + Flèche Bas` (Windows/Linux) ou `Option + Flèche Bas` (Mac) pour envoyer la ligne suivante à Rocq.
- **Reculer (Step Backward) :** Appuyez sur `Alt + Flèche Haut` ou `Option + Flèche Haut` pour annuler la dernière étape. (Si vous faites une erreur, reculez simplement, corrigez le texte dans l'éditeur, et avancez à nouveau).

## 3. Les Tactiques de Base : Travailler à l'envers
Les tactiques sont des commandes qui construisent le λ-terme sous-jacent pour vous. Dans Rocq, nous construisons généralement les preuves à l'envers : nous regardons le but (Goal), et nous appliquons une tactique qui le décompose en sous-buts plus simples.

### `intro.` ou `intros.`
- **Ce que ça fait :** Introduit des variables ou des hypothèses. Cela correspond à la λ-abstraction.
- **Quand l'utiliser :** Quand votre but est une implication (par ex., `A -> B`).
- **Effet :** Prend le `A`, le déplace au-dessus de la ligne dans votre contexte, et laisse `B` comme nouveau but.
- **Exemple :** `intros x y.` fait monter deux prémisses et les nomme `x` et `y`.

### `exact.`
- **Ce que ça fait :** Résoud le but courant.
- **Quand l'utiliser :** Quand votre but correspond exactement au type d'une hypothèse que vous avez déjà au-dessus de la ligne dans votre contexte.
- **Exemple :** Si votre but est `A`, et que vous avez `x : A` au-dessus de la ligne, tapez `exact x.`.

### `apply.`
- **Ce que ça fait :** Utilise une fonction ou une implication (Modus Ponens) à l'envers.
- **Quand l'utiliser :** Quand votre but correspond à la conclusion d'une hypothèse que vous avez dans votre contexte.
- **Effet :** Si votre but est `B`, et que vous avez une hypothèse `f : A -> B` au-dessus de la ligne, taper `apply f.` changera votre but en `A`. (cela se lit ainsi : "Prouver A est suffisant pour prouver B, car f fera le reste du chemin.")

## 4. La Check-list "Panique"
Si une tactique échoue et vous donne une erreur :
- **Lisez le but attentivement :** Essayez-vous de faire un `apply` avec une hypothèse dont la conclusion ne correspond pas au but actuel ?
- **Vérifiez votre contexte :** Est-ce-que le nom de l'hypothèse invoquée avec `exact` ou `apply` apparaît bien dans le contexte ?
- **Faites un pas en arrière :** Si après réflexion le but ne vous semble pas prouvable, utilisez la flèche Haut pour revenir en arrière et essayez une autre tactique.
# Leçon 2 : Logique propositionnelle & Constructivisme

Aujourd'hui, nous allons voir comment exprimer dans Rocq des raisonnements dans la logique propositionnelle complète. Nous allons donc rajouter au connecteur de l'implication → les connecteurs habituels : conjonction ∧, disjonction ∨, absurdité ⊥, et négation ¬.

Rappelons nous que Rocq est fondé sur une extension du λ-calcul simplement typé appelée Calcul des Constructions Inductives (CoIC). Via la correspondence de Curry-Howard, la logique naturellement supportée par Rocq est donc constructive/intuitionniste. Nous ne pourrons pas dans ce cours couvrir l'entièreté de CoIC, mais nous allons tout de même voir aujourd'hui les constructions de base qui permettent de donner un contenu calculatoire aux différents connecteurs propositionnels.

Les explications que je vais donner sont basées sur une sémantique constructive (informelle) très connue pour les connecteurs qui émergea dans les années 1930 \cite{troelstraHistoryConstructivism20th2011}, _l'interprétation BHK_ (pour Brouwer-Heyting-Kolmogorov, les mathématiciens/logiciens qui en sont à l'origine).
Ici nous allons donner une implémentation concrète de BHK basée sur une extension des termes du λ-calcul.

```meta
Dans les slides qui suivent, pour chaque connecteur, on souhaite afficher dans un premier temps les règles d'introduction et d'élimination du connecteur en déduction naturelle (en bleu); puis on rajoute les annotations de termes correspondantes (en rouge), en utilisant la syntaxe traditionnelle sur papier car plus économique en espace; et finalement, on donne l'élimination des détours correspondante, incluant la syntaxe de termes (uniquement pour conjonction/disjonction).

Je montrerai en même temps, au fur et à mesure et dans une démo live avec jsCoq, la syntaxe Rocq correspondante pour les termes et les tactiques.
```

## Rappel : Implication

## Conjonction

## Disjonction

## Absurdité

## Négation

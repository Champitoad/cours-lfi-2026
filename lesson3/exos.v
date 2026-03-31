(** * LEÇON 3 : Logique du Premier Ordre et Égalité *)

(** Après avoir exploré la logique propositionnelle, nous passons aujourd'hui à la 
    logique des prédicats (ou logique du premier ordre). Nous allons voir comment 
    Rocq gère les quantificateurs universels (POUR TOUT) et existentiels (IL EXISTE), 
    ainsi que la notion fondamentale d'égalité. 

    Dans Rocq, les prédicats sont simplement des fonctions qui renvoient une 
    proposition ([Prop]). Par exemple, un prédicat [P] sur un type [T] a le type 
    [T -> Prop]. *)

Section Lesson3.

(** On suppose l'existence d'un type d'individus abstrait [T], et de plusieurs prédicats. *)
Variable T : Type.
Variable P Q : T -> Prop.
Variable R : T -> T -> Prop.

(** * PARTIE 1 : LE QUANTIFICATEUR UNIVERSEL (POUR TOUT : forall) *)

(** En logique, affirmer "Pour tout individu x, P(x) est vrai" signifie que si 
    on me donne n'importe quel individu x, je peux fournir une preuve de P(x).
    
    Informatiquement (grâce à Curry-Howard), c'est une FONCTION ! Une fonction 
    qui prend en argument un élément [x] de type [T], et qui renvoie une preuve 
    du type [P x]. C'est ce qu'on appelle un type dépendant (le type de retour
    dépend de la valeur de l'argument).
    
    Ainsi, l'implication simple [A -> B] que nous connaissons bien n'est en fait
    qu'un [forall] dégénéré où le type de retour ne dépend pas de l'argument !
    C'est pour cela qu'on utilise la même tactique [intro] / [intros]. *)
Lemma forall_intro : (forall x : T, P x -> Q x) -> (forall x : T, P x) -> (forall y : T, Q y).
Proof.
  intros H_impl H_P.
  (** Notre but commence par [forall y : T, ...]. Nous voulons prouver que la propriété
      est vraie pour un [y] arbitraire. Nous l'introduisons dans le contexte. *)
  intro y.
  (** Maintenant que nous avons un [y] spécifique (mais quelconque), 
      notre but est logiquement [Q y]. *)
  apply H_impl.
  (** REMARQUE : Comment Rocq a-t-il su utiliser [H_impl] ?
      Notre but était [Q y] et la conclusion de [H_impl] était [Q x].
      La machine a superposé les deux expressions et a deviné toute seule
      qu'il fallait remplacer [x] par l'individu [y] !
      Ce mécanisme automatique de "mise en correspondance" (un puzzle
      syntaxique de remplissage de trous) effectué silencieusement 
      sous le capot s'appelle l'**unification**. *)
  apply H_P.
Qed.

(** * PARTIE 2 : LE QUANTIFICATEUR EXISTENTIEL (IL EXISTE : exists) *)

(** Du point de vue constructiviste, prouver "Il existe un x tel que P(x)", 
    ce n'est pas simplement dire "ça doit bien exister quelque part". 
    Il faut EN EXHIBER UN ! 
    
    Une preuve d'existence est donc une PAIRE constituée de :
    1. Un "témoin" [x] de type [T] (la valeur concrète).
    2. Une preuve que ce témoin [x] satisfait bien la propriété [P].
    
    Pour construire une telle paire, on utilise la tactique [exists] en
    lui fournissant notre témoin. *)
Lemma exists_intro : (forall x : T, P x) -> (exists y : T, P y \/ Q y).
Proof.
  intros H_P.
  (** Nous voulons prouver une existence. Il faut fournir un témoin. 
      Imaginons que nous avons au moins un élément dans notre domaine...
      Attendez, nous n'avons aucun élément [t : T] dans notre contexte !
      Le domaine [T] pourrait être vide, auquel cas l'existence est fausse. *)
Abort.

(** Ajoutons donc une hypothèse affirmant que notre domaine n'est pas vide. *)
Variable t_defaut : T.

Lemma exists_intro : (forall x : T, P x) -> (exists y : T, P y \/ Q y).
Proof.
  intros H_P.
  (** Nous utilisons notre élément [t_defaut] comme témoin de l'existence. *)
  exists t_defaut.
  (** Remarquez que le but a changé : Rocq a remplacé tous les [y] par [t_defaut].
      Il ne nous reste plus qu'à en donner la preuve. *)
  left.
  apply H_P.
Qed.

(** À l'inverse, si nous possèdons une hypothèse existentielle [exists x, P x], 
    nous voulons en extraire le témoin et la preuve associée. Comme c'est
    une paire sous le capot (tout comme le ET), on utilise la tactique [destruct]. *)
Lemma exists_elim : (exists x : T, P x /\ Q x) -> (exists y : T, P y).
Proof.
  intros H_exists.
  (** On détruit l'hypothèse pour récupérer le témoin (que l'on nomme [x0])
      et la preuve qu'il satisfait la propriété (qu'on nommera [H_PQ]). *)
  destruct H_exists as [x0 H_PQ].
  destruct H_PQ as [H_P H_Q].
  (** On peut maintenant reconstruire notre propre existence en utilisant 
      ce même témoin [x0]. *)
  exists x0.
  exact H_P.
Qed.

(** * PARTIE 3 : L'ÉGALITÉ PROPOSITIONNELLE (Le signe =) *)

(** En mathématiques, l'égalité est la notion la plus fondamentale. Dans Rocq, [x = y] est une
      proposition. Dire que [x = y] est prouvable, c'est dire que [x] et [y] dénotent
      formellement le même objet.

    L'outil principal pour manipuler l'égalité est la RÈGLE DE SUBSTITUTION : Si [x = y], alors tout
    ce qui est vrai pour [x] est vrai pour [y]. C'est la tactique [rewrite].

    (Note philosophique : Ce comportement trouve ses racines dans le principe d'identité des
     indiscernables de Leibniz, que nous approfondirons la semaine prochaine !) *)
Lemma egalite_sym : forall x y : T, x = y -> y = x.
Proof.
  intros x y H_eq.
  (** Nous savons que [x] et [y] sont égaux (hypothèse H_eq).
      Nous voulons prouver [y = x].
      La tactique [rewrite] permet de remplacer le membre gauche de l'égalité
      par le membre droit partout dans le but. *)
  rewrite H_eq.
  (** Notre but [y = x] s'est transformé en [y = y]. *)
  reflexivity.
Qed.

(** La tactique [reflexivity] prouve instantanément que tout terme est 
    égal à lui-même ([x = x]). Mais c'est plus profond que ça ! *)

(** * PARTIE 4 : ÉGALITÉ DÉFINITIONNELLE vs PROPOSITIONNELLE *)

(** Rocq distingue deux types d'égalités :
    1. L'égalité PROPOSITIONNELLE ([x = y]) : c'est un énoncé logique qu'il faut 
       prouver (par exemple avec [rewrite], en appliquant des lemmes).
    2. L'égalité DÉFINITIONNELLE : c'est le fait que deux expressions se 
       "calculent" pour donner le même résultat de manière purement mécanique 
       (via $\beta\eta$-équivalence et déroulage de définitions). 
       
    La magie, c'est que la tactique [reflexivity] réussit modulo l'égalité
    définitionnelle ! Le système évalue discrètement les termes. *)

Definition doubler (n : nat) : nat := n + n.

Lemma reflexivite_puissante : doubler 2 = 4.
Proof.
  (** Pour un logicien minutieux sur papier, il y a un petit travail de démonstration ici (par
        exemple avec les axiomes de Peano). Mais pour Rocq, [doubler 2] s'évalue mécaniquement
        en [2 + 2], puis en [4]. Ensuite il constate que [4 = 4] est correct et conclut. *)
  reflexivity.
Qed.

(** C'est cette intégration du calcul AU CŒUR MÊME des règles de déduction
    qui rend la théorie des types intuitionniste particulièrement adéquate 
    pour la formalisation assistée par ordinateur, contrairement à des fondations 
    plus classiques tels que la théorie des ensembles ZFC. *)

(** * PARTIE 5 : EXERCICES À FAIRE *)

(** EXERCICE 1 : Prouver que l'égalité est transitive. *)
Lemma egalite_trans : forall x y z : T, x = y -> y = z -> x = z.
Proof.
  (* ÉCRIVEZ VOTRE PREUVE ICI *)
Admitted.

(** EXERCICE 2 : Raisonnement équationnel usuel.
    Montrez comment utiliser [rewrite] pour substituer [y] par [z] au 
    sein du prédicat binaire [R]. *)
Lemma equation_exemple : forall x y z : T,
  R x y -> y = z -> R x z.
Proof.
  (* ÉCRIVEZ VOTRE PREUVE ICI *)
Admitted.

End Lesson3.

(* ================================================================= *)
(* Leçon 2 : Logique Propositionnelle et Constructivisme             *)
(* ================================================================= *)

(* Lors de la première leçon, nous avons vu l'implication (->).
   Aujourd'hui, nous allons introduire la conjonction (ET), 
   la disjonction (OU), et la négation (NON). *)

Section Lecon2.
Variables P Q R : Prop.

(* ================================================================= *)
(* PARTIE 1 : La Conjonction (Le ET : /\ )                           *)
(* ================================================================= *)

(* Pour prouver 'P /\ Q', nous devons fournir deux choses : 
   une preuve de P, ET une preuve de Q. 
   La tactique pour diviser ce but en deux est 'split'. *)

Lemma ET_intro : P -> Q -> P /\ Q.
Proof.
  intros p q.
  split.
  - exact p. (* Le tiret '-' permet de se concentrer sur le 1er sous-but *)
  - exact q. (* Et ici sur le 2ème sous-but *)
Qed.

(* Si nous AVONS un 'P /\ Q' dans nos hypothèses, comment l'utiliser ?
   Nous devons le "détruire" pour en extraire les deux composants.
   La tactique est 'destruct'. *)

Lemma ET_symetrie : P /\ Q -> Q /\ P.
Proof.
  intro H.
  destruct H as [p q]. (* Extrait les preuves p:P et q:Q de l'hypothèse H *)
  split.
  - exact q.
  - exact p.
Qed.

(* ================================================================= *)
(* PARTIE 2 : La Disjonction (Le OU : \/ )                           *)
(* ================================================================= *)

(* L'approche de Rocq est CONSTRUCTIVISTE. Pour prouver 'P \/ Q', 
   vous DEVEZ prouver P, ou bien prouver Q. 
   Les tactiques sont 'left' (pour choisir de prouver le côté gauche) 
   et 'right' (pour choisir le côté droit). *)

Lemma OU_intro_gauche : P -> P \/ Q.
Proof.
  intro p.
  left. (* "Je choisis de prouver P, car j'ai une preuve de P !" *)
  exact p.
Qed.

(* Pour utiliser un OU qui est dans nos hypothèses, on utilise 
   aussi 'destruct'. Cela va créer deux mondes parallèles : 
   un monde où P est vrai, et un monde où Q est vrai. *)

Lemma OU_symetrie : P \/ Q -> Q \/ P.
Proof.
  intro H.
  destruct H as [p | q]. (* La barre '|' sépare les deux cas possibles *)
  - (* Cas 1 : On suppose que c'était P *)
    right. exact p.
  - (* Cas 2 : On suppose que c'était Q *)
    left. exact q.
Qed.

(* ================================================================= *)
(* PARTIE 3 : La Négation et la Crise Constructiviste                *)
(* ================================================================= *)

(* Dans Rocq, la négation '~P' est juste une abréviation pour 'P -> False'. 
   Prouver '~P', c'est prouver que supposer P mène à une absurdité. *)

Lemma non_contradiction : ~(P /\ ~P).
Proof.
  intro H.
  destruct H as [p non_p].
  (* Nous avons 'p : P' et 'non_p : P -> False'. Modus Ponens ! *)
  apply non_p.
  exact p.
Qed.

(* Mais que se passe-t-il si nous essayons de prouver le principe 
   du Tiers Exclu (Tout est soit vrai, soit faux) à partir de rien ? *)

Lemma tiers_exclu_fail : P \/ ~P.
Proof.
  (* Essayons... Si je fais 'left', je dois prouver P. Mais je n'ai rien !
     Si je fais 'right', je dois prouver ~P. Mais je n'ai rien non plus ! 
     Dans un monde constructif, on ne peut pas affirmer P \/ ~P sans 
     savoir concrètement lequel des deux est vrai. *)
Abort. (* 'Abort' annule la preuve en cours. *)

(* ================================================================= *)
(* PARTIE 4 : L'Axiome et la Logique Classique                       *)
(* ================================================================= *)

(* Pour faire des mathématiques classiques, nous devons imposer 
   le Tiers Exclu comme une loi universelle. 
   Nous utilisons la commande 'Axiom'. *)

Axiom LEM : forall A : Prop, A \/ ~A.

(* L'univers logique vient de changer ! 
   Nous pouvons maintenant prouver l'élimination de la double négation, 
   qui est impossible en logique purement constructiviste. *)

Lemma double_negation : ~~P -> P.
Proof.
  intro non_non_p.
  (* Nous invoquons notre axiome divin pour séparer l'univers en deux *)
  destruct (LEM P) as [p | non_p].
  - (* Cas 1 : P est vrai. Facile ! *)
    exact p.
  - (* Cas 2 : P est faux (~P). 
       Mais on nous a donné hypothèse ~~P (c'est-à-dire ~P -> False). *)
    (* Nous avons une contradiction entre non_p et non_non_p ! *)
    exfalso. (* "De cette absurdité, je peux tout déduire" *)
    apply non_non_p.
    exact non_p.
Qed.

End Lecon2.
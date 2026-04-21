# Leçon 6 — Vérification formelle à l'ère de l'IA

**Sous-titre :** Promesses, retournements, questions ouvertes
**Public :** étudiants en philosophie (cours LFI-2026, 6 séances)
**Durée visée :** 30–40 min
**Structure :** arc dialectique en 3 actes (thèse → antithèse → synthèse ouverte)

---

## Slide 1 — Titre

- Titre, sous-titre, auteur, institution, année.

**Note présentateur**
- Dernière séance : du λ-calcul aux types inductifs (Curry-Howard, déduction naturelle).
- Trois temps :
  1. **Promesse** — vérification formelle + IA : nouvelle ère pour maths et sûreté.
  2. **Retournement** — en 2026, les noyaux eux-mêmes sont faillibles, et l'IA est un adversaire redoutable.
  3. **Questions ouvertes** — discussion.

---

# ACTE I — LA PROMESSE

## Slide 2 — Du rêve de Leibniz à la vérification formelle

**Colonne gauche**
- Leibniz XVIIᵉ : *characteristica universalis* + *calculus ratiocinator*.
- Réalisations :
  - **seL4** — noyau OS prouvé
  - **CompCert** — compilateur C certifié
  - **4 Couleurs**, **Kepler** (Flyspeck)
- *Mais : 20 personnes-années pour seL4, 6 p.-a. pour CompCert.*

**Colonne droite**
- **Le pari** : garanties *mathématiques* là où l'ingénierie classique n'en offre pas.
- Benzmüller : logique d'ordre supérieur comme *meta-logique universelle*.

**Note présentateur**
- Rappel du paysage (leçon 1), recadré comme un *pari* sur les garanties formelles.
- Goulot historique : humain — les preuves sont longues/coûteuses.
- Question directrice : et si l'IA levait ce goulot ?

---

## Slide 3 — La nouvelle division du travail : l'IA génère, le noyau vérifie

**Schéma TikZ (3 boîtes)**
- **Humain** (spécification, intuition) → énoncé `Theorem T : …` → **LLM / IA** (génère tentatives de preuve) → tactiques/terme → **Noyau Rocq/Lean** (vérifie λ-terme).
- Retour : échec/feedback vers LLM ; certificat vérifié vers humain.

**Points-clés**
- **Autoformalisation** : informel → Rocq/Lean (Buzzard).
- **Tactic search** : AlphaProof.
- **L'IA propose, le noyau dispose.**

**Note présentateur**
- Asymétrie fondamentale : IA peut halluciner, le noyau refuse tout terme mal typé.
- Parallèle leçon 5 : un `Fixpoint` bien typé termine, peu importe qui l'a écrit.

---

## Slide 4 — Mathématiques formalisées : l'appétit de l'IA

**Colonne gauche**
- **Avigad** — *tournant formel*.
- **Buzzard** — après le calcul, le *raisonnement* ?
- Jalons :
  - Liquid Tensor Experiment
  - Mathlib
  - Problèmes d'Erdős
  - AlphaProof (IMO 2024)

**Colonne droite**
- **Severini** : ≈ 0,05 % des maths formalisées. L'IA a faim de corpus vérifié → la formalisation devient *application phare*.
- **Massot** : outil, pas substitut.

**Note présentateur**
- Moteur n'est plus seulement scientifique mais économique/infrastructurel.
- Nuance Massot : enrichir la pratique, pas la remplacer. Pluralité de pratiques.

---

## Slide 5 — Au-delà des maths : sûreté de l'IA par la preuve

- **Tegmark & Omohundro** — *Provably Safe Systems* : seule voie vers une AGI contrôlable.
- *Pause*
  1. Alignement (RLHF, monitoring) → garanties **statistiques**.
  2. Preuve formelle → garantie **mathématique**.
  3. L'IA rend l'approche **faisable** à grande échelle.
- *Pause*
- **La promesse ultime** : Vérification + IA = sûreté des systèmes critiques, *y compris* des IA.

**Note présentateur**
- Sommet de l'arc promesse.
- Pointer la tension : le problème de la **spécification** reste entier (prouver « ne pas nuire » ≠ prouver l'absence de dépassement de pile).
- Transition vers acte II : et si le cadre technique lui-même était fragile ?

---

# ACTE II — LE RETOURNEMENT

## Slide 6 — Qui vérifie le noyau ?

- *Pont transitionnel (italique) :* « Si on fonde la sûreté sur la preuve, tout repose sur le vérificateur — commençons par lui. »
- **Critère de de Bruijn** : noyau *minimal*, vérificateur de λ-termes, auditable par un humain.
- Points-clés :
  - Pas de confiance dans les tactiques.
  - Confiance dans le **noyau** (~ quelques milliers de lignes).
  - Noyau correct ⇒ toute preuve acceptée est correcte.
- *Pause*
- **Régression** : noyau correct ? compilateur du noyau ? matériel ?

**Note présentateur**
- Transition courte. Idée clé : noyau minimal = pierre angulaire, mais régression potentiellement infinie.
- Exactement la question Ken Thompson 1984.

---

## Slide 7 — Thompson 1984 — *Reflections on Trusting Trust*

**Colonne gauche**
- Ken Thompson, conférence Turing Award.
- **Compilateur C malveillant** :
  1. Porte dérobée injectée dans `login`.
  2. S'auto-reproduit à la compilation d'un compilateur.
- Source *propre* → binaire *compromis*.

**Colonne droite**
- **Thèse** : *« You can't trust code that you did not totally create yourself. »*
- **Conséquence** : la vérification *déplace* la confiance — elle ne l'élimine pas.

**Note présentateur**
- Argument de 1984, toujours actuel. Origine de la notion de *trusted computing base*.
- Justifie de Bruijn : minimiser le noyau = minimiser la surface d'attaque.
- Mais un petit noyau doit s'exécuter quelque part — et ce « quelque part » n'est pas prouvé.
- Annonce : en 2026, on a des exemples concrets de chaque niveau qui craque.

---

## Slide 8 — Le retournement 2026 : l'IA casse le cadre *(slide centrale)*

**Trois colonnes — trois événements 2026**

**Colonne 1 — Mythos (Anthropic, avril 2026)**
- 0-days dans OpenBSD, Linux, FreeBSD.
- Milliers de vulnérabilités.
- Source reconstruite depuis binaires fermés.
- *L'IA comme attaquant de classe nouvelle.*

**Colonne 2 — `False` dans Rocq (mars 2026)**
- Sept preuves de `False` via bugs indépendants.
- Guard checker, modules.
- IA + humain, avec l'équipe Rocq.
- *Le noyau minimal n'est pas infaillible.*

**Colonne 3 — *Watchers* / `lean-zip` (avril 2026)**
- Décodeur ZIP prouvé en Lean 4.
- Parseur d'archive non vérifié : overflow.
- Exploit via ZIP de 156 octets.
- *Preuve OK, runtime cassé.*

- **Pied de slide :** *Trois niveaux, trois fractures simultanées.*

**Note présentateur**
- Slide centrale du cours — prendre le temps.
- **Mythos** : exploits RCE, ROP, JIT ; retrouve des bugs 27 ans après. Retourne Tegmark : l'IA qui vérifie = l'IA qui casse.
- **Rocq** : sept preuves indépendantes de `False` (guard checker, modules). Noyau « base de confiance » vendu en leçon 1 a plusieurs trous. Travail mixte IA (Opus 4.6 de Stérin) + ingénieurs Rocq.
- **Lean** : cas philosophiquement le plus clair. Le décodeur ZIP est prouvé ; c'est le code *appelant* (`lean_alloc_sarray`) qui n'est pas vérifié → heap overflow. Thompson 1984 littéralement appliqué à la vérification formelle.

---

## Slide 9 — Trois niveaux de confiance, ré-examinés

**Schéma TikZ (3 couches empilées)**
1. **Spécification** — ¿ Formaliser les valeurs ?
2. **Noyau** — `False` (Opus 4.6, Rocq).
3. **Runtime / compilateur / matériel** — Overflow Lean.

- **À retenir** : pas de garantie absolue. Garanties *relatives* à des hypothèses explicites.

**Note présentateur**
- Point dialectique : on n'a pas réfuté la vérification formelle, on l'a recadrée.
- Analogie : prouver en maths dépend des axiomes ; prouver en Rocq dépend du noyau, runtime, matériel.
- La bonne question : « à quoi faisons-nous confiance, et est-ce justifié ? »

---

# ACTE III — QUESTIONS OUVERTES

## Slide 10 — Discussion — Think/Pair/Share

- **Format** : 2 min seul, 3 min en binôme, mise en commun.
- Quatre questions (on en traitera 2) :
  1. **IA : adversaire ou garante ?** Red team systématique, ou perte de confiance ?
  2. **Formaliser Spinoza, Gödel** (Pommeret ; Benzmüller ; Kirchner-Zalta). Traduction fidèle, ou ré-interprétation ?
  3. **Comprendre vs. vérifier.** Preuve de 10 000 lignes jamais lue — qui la comprend ?
  4. **Sûreté prouvable (Tegmark) : voie royale ou illusion ?** Peut-on prouver des valeurs non-formelles ?

**Note présentateur**
- Gérer le temps : 2 questions max.
- Choix selon énergie/intérêt : Q2 philosophique, Q4 IA safety, Q1 concret, Q3 épistémologique.
- Sur Q3 : Gonthier (4 couleurs) et Hales (Kepler) — leurs preuves formelles ne sont lues par personne intégralement, seulement vérifiées. Est-ce « faire des maths » ?

---

## Slide 11 — Bilan — six semaines

**Colonne gauche — Savoir-faire**
- Habiter un type.
- Déduction naturelle.
- Rocq : `Inductive`, `Fixpoint`, `induction`.
- Formaliser un énoncé.

**Colonne droite — Philosophiquement**
- **Curry-Howard** : preuves = programmes.
- **Constructivisme**.
- **Vérificationnisme**.
- **Mécanisation** du travail épistémique.
- **Confiance** déplacée, pas supprimée.

**Encadré « Pour la suite »**
- DM — `rev ∘ rev = id` — 25 avril.
- *Calculemus, mais lucidement.*

**Note présentateur**
- Clore proprement. Remercier.
- Insister sur le double niveau (technique + philosophique) maintenu sur 6 semaines.
- Moment historique : tournant formel s'accélère, questions épistémologiques loin d'être résolues. Les philosophes ont quelque chose à dire.

---

## Slide 12 — Bibliographie

- Bibliographie complète imprimée via `biblatex` (`allowframebreaks`, `\tiny`).

---

## Architecture dialectique (vue d'ensemble)

| Acte | Slides | Fonction |
|------|--------|----------|
| I — Promesse | 2–5 | Thèse : vérification formelle + IA = nouvelle ère (maths, sûreté). |
| II — Retournement | 6–9 | Antithèse : les trois niveaux (spec, noyau, runtime) sont faillibles ; l'IA est aussi adversaire. |
| III — Questions ouvertes | 10–11 | Synthèse : pas de garantie absolue ; confiance déplacée ; discussion philosophique. |

## Continuité narrative (fil conducteur)

1. Slide 2 pose **le pari** (garanties mathématiques, coût humain).
2. Slide 3 montre **comment l'IA change la donne** (division du travail).
3. Slides 4–5 déploient **les domaines d'application** (maths, puis sûreté de l'IA).
4. Slide 6 **retourne la focale** vers le vérificateur lui-même.
5. Slide 7 donne **l'argument théorique** (Thompson).
6. Slide 8 livre **les preuves empiriques 2026** aux trois niveaux.
7. Slide 9 **recadre** : garanties conditionnelles.
8. Slides 10–11 **ouvrent** la discussion et clôturent les 6 semaines.

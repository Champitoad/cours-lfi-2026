# Leçon 6 — Vérification formelle à l'ère de l'IA

_Notes de cours — version continue, à lire d'une traite_

---

## Ouverture (slide 1)

Nous voici donc à la dernière séance. En six semaines, nous avons parcouru un chemin qui, à première vue, pouvait sembler aride : le λ-calcul, la déduction naturelle, les types inductifs, l'induction, la récursion, le tout habillé dans un assistant de preuve appelé Rocq (anciennement Coq). Nous avons vu comment, via la correspondance de Curry-Howard, une preuve mathématique et un programme informatique étaient, littéralement, deux facettes d'une même chose. Nous avons appris à _habiter_ un type, c'est-à-dire à construire un terme qui témoigne de sa vérité.

La séance d'aujourd'hui n'introduit pas de nouveau concept technique. Elle est plutôt une prise de recul, une tentative de répondre à la question que vous êtes peut-être en train de vous poser : _à quoi bon tout cela ?_ Pourquoi avoir consacré six semaines à cette discipline étrange qui mélange logique mathématique et informatique, alors que le monde, lui, continue de tourner sur du code non-vérifié ?

Pour y répondre, nous allons dérouler un récit en trois actes. Dans le premier, je vais vous présenter **la promesse** — l'idée, portée aujourd'hui par des chercheurs sérieux, que la combinaison de la vérification formelle et de l'intelligence artificielle ouvre une ère nouvelle : pour les mathématiques d'abord, puis pour la sûreté des systèmes critiques, y compris de l'IA elle-même. Dans le deuxième, je vous raconterai **le retournement** — parce qu'en 2026, cette année même, trois événements sont venus nous rappeler que ce grand édifice repose sur des fondations qu'on croyait solides, mais qui se sont révélées faillibles. Et dans le troisième, je ne vous proposerai pas de conclusion définitive ; je vous soumettrai plutôt quelques **questions ouvertes** dont je crois que vous, philosophes, êtes particulièrement bien placés pour vous emparer.

---

# Acte I — La promesse

## 1. Du rêve de Leibniz à la vérification formelle (slide 2)

Commençons par situer historiquement ce que nous faisons. Au XVIIᵉ siècle, Leibniz rêve d'une _characteristica universalis_ : une langue universelle dans laquelle tout raisonnement pourrait s'exprimer sans ambiguïté, couplée à un _calculus ratiocinator_, un mécanisme de calcul qui permettrait de résoudre les désaccords intellectuels comme on résout une équation. Face à un différend, dit-il en substance, il suffirait de s'asseoir et de dire : _calculemus_, calculons.

Ce rêve est resté longtemps un rêve. Il a fallu attendre le XXᵉ et le XXIᵉ siècles pour qu'il prenne corps, partiellement, sous la forme de ce qu'on appelle aujourd'hui la _vérification formelle_. Le principe en est simple à énoncer : on écrit une spécification mathématique de ce qu'un système doit faire ; on écrit le système ; et on produit une preuve, vérifiée mécaniquement, que le système satisfait la spécification.

Les réalisations sont réelles. **seL4**, un micro-noyau de système d'exploitation, a été entièrement prouvé correct en 2009 : on peut démontrer mathématiquement qu'il n'a pas de bugs — pas de débordement de tampon, pas de fuite mémoire, pas de violation d'invariant. **CompCert**, un compilateur C développé par Xavier Leroy et son équipe, produit du code machine dont on a prouvé qu'il est sémantiquement équivalent au code source : le compilateur ne peut pas introduire subrepticement un bug. Dans un autre registre, le théorème des **quatre couleurs** a été entièrement formalisé en Coq par Gonthier, et la **conjecture de Kepler** sur l'empilement des sphères a été formalisée par Hales dans le projet Flyspeck.

Cela représente, dans des domaines où l'enjeu est critique, des **garanties mathématiques** — là où l'ingénierie classique n'offre au mieux que des tests, c'est-à-dire une confiance statistique dans le fait que les cas qu'on a testés sont représentatifs des cas qu'on n'a pas testés. On parle donc bien d'un saut qualitatif, au moins en principe.

Mais il faut immédiatement ajouter une nuance, et elle est de taille : **ces réalisations coûtent très cher**. La preuve de seL4 a demandé une vingtaine de années-personnes de travail. CompCert, une grosse demi-douzaine. Les mathématiciens qui formalisent un théorème important en Lean ou en Rocq estiment souvent le coût à un facteur dix ou vingt par rapport à la rédaction classique. C'est ce qu'on appelle le _goulot d'étranglement humain_ : la vérification formelle marche, mais elle ne passe pas à l'échelle, parce que l'écriture des preuves demande une expertise rare et un temps considérable.

D'où la question qui va structurer tout l'acte I : _et si l'intelligence artificielle faisait sauter ce goulot ?_

## 2. La nouvelle division du travail (slide 3)

C'est ici qu'il faut comprendre une idée structurante, que je vais essayer d'énoncer le plus clairement possible, parce qu'elle sera le pivot de toute la séance.

Dans le paradigme classique, la vérification formelle fonctionne selon une division du travail très stricte. D'un côté, il y a **l'humain**, qui écrit la spécification (ce qu'on veut prouver) et qui écrit la preuve elle-même, pas à pas, en combinant des tactiques. De l'autre, il y a **le noyau** de l'assistant de preuve — un petit programme d'environ quelques milliers de lignes, dont le seul travail est de vérifier qu'un λ-terme est bien typé. Si le terme type, la preuve est acceptée. Sinon, elle est rejetée. Le noyau ne comprend rien au contenu mathématique ; il applique mécaniquement les règles du système de types.

Ce que l'IA change, ce n'est pas le noyau — c'est le rôle de l'humain. Avec les grands modèles de langage, on peut désormais imaginer le schéma suivant : l'humain écrit seulement la spécification, l'énoncé, quelque chose comme `Theorem T : ...`. Un modèle de langage, un LLM, génère alors des tentatives de preuve — soit sous forme de tactiques, soit directement sous forme de λ-termes. Ces tentatives sont envoyées au noyau, qui les vérifie. Si elles passent, parfait, on a un certificat vérifié. Si elles échouent, le message d'erreur est renvoyé au LLM, qui réessaye.

Ce schéma a une propriété remarquable, sur laquelle je veux vraiment insister : **l'IA peut être aussi mauvaise qu'on veut, cela ne compromet pas la correction du résultat**. Elle peut halluciner, inventer des lemmes qui n'existent pas, se contredire, cela n'a aucune importance. Le noyau, lui, ne ment pas. Tout terme qui ne type pas est rejeté. C'est ce qu'on pourrait appeler, en paraphrasant Thomas à Kempis : _l'IA propose, le noyau dispose_.

C'est exactement le parallèle que nous avons fait la semaine dernière avec les `Fixpoint` : un `Fixpoint` bien typé est garanti de terminer, peu importe que ce soit un étudiant débutant ou un expert qui l'ait écrit. Le système de types est notre arbitre neutre, impartial. Il ne se laisse pas impressionner.

C'est ce caractère d'_asymétrie_ qui rend le mariage entre IA et vérification formelle si séduisant. Dans presque toutes les autres applications de l'IA, on doit faire confiance à l'IA pour que le résultat soit bon. Ici, on n'a pas besoin de lui faire confiance. On lui fait faire le travail ingrat (chercher la preuve), mais on garde la main sur la validation.

## 3. Les mathématiques : l'appétit de l'IA (slide 4)

Cette nouvelle division du travail produit un effet déjà visible dans le monde mathématique. Jeremy Avigad, philosophe et logicien à Carnegie Mellon, parle de _tournant formel_ des mathématiques. Kevin Buzzard, mathématicien à Imperial College, dit à peu près ceci : depuis les années 1960, les ordinateurs savent _calculer_ ; depuis quelques années, il semble qu'ils commencent à savoir _raisonner_.

Les jalons sont impressionnants. Le **Liquid Tensor Experiment**, lancé par Peter Scholze, a consisté à formaliser en Lean un résultat de ses propres travaux dont il n'était pas entièrement sûr — et la formalisation a effectivement révélé un détail subtil dans la preuve originale. **Mathlib**, la bibliothèque mathématique de Lean, contient désormais une part croissante du contenu d'une licence de maths. Un projet collectif en ligne vise à formaliser les **problèmes d'Erdős**. Et, peut-être l'événement le plus médiatisé, **AlphaProof** de DeepMind a résolu l'an dernier plusieurs problèmes de l'Olympiade internationale de mathématiques, au niveau médaille d'argent, en formalisant automatiquement ses solutions en Lean.

Il y a un argument de Simone Severini, dans un article récent, qui me paraît particulièrement éclairant pour situer ce qui se passe. Il fait remarquer que, à l'heure actuelle, environ **0,05 % des mathématiques publiées** sont formalisées. Autrement dit, c'est une goutte d'eau. Mais — et c'est son point — les IA modernes ont un appétit féroce pour les _corpus vérifiés_. Elles apprennent beaucoup mieux quand on peut leur fournir non seulement du texte mais du texte dont la correction est garantie. Du coup, la formalisation, qui était jusqu'ici un hobby d'universitaires passionnés, devient une **application phare** économiquement stratégique. Les grands laboratoires d'IA ont désormais un intérêt direct à financer et à accélérer la formalisation.

Ce qui est intéressant philosophiquement, c'est que le moteur de la formalisation n'est plus seulement _scientifique_ (comprendre, prouver, publier) mais désormais aussi _infrastructurel_ : on formalise parce que les IA en ont besoin pour s'entraîner. C'est une inversion subtile mais profonde.

Ceci dit, il faut rester lucide. Patrick Massot, l'un des mathématiciens les plus actifs dans Mathlib, le dit très clairement : pour les mathématiciens, la formalisation est un _outil_, pas un _substitut_. Personne, parmi les gens sérieusement impliqués, ne pense que dans dix ans on aura remplacé les mathématiques par leurs versions Lean. Il y a, et il continuera d'y avoir, une pluralité de pratiques : preuve informelle lue par des humains, preuve semi-formelle, preuve intégralement mécanisée. Ces pratiques ne s'excluent pas ; elles s'enrichissent mutuellement.

## 4. Au-delà des maths : la sûreté de l'IA par la preuve (slide 5)

Jusqu'ici, nous sommes restés dans le domaine des mathématiques. Mais il y a un argument, porté par Max Tegmark (physicien au MIT) et Steve Omohundro, qui pousse la logique beaucoup plus loin. Leur thèse, développée dans un article intitulé _Provably Safe Systems_, est la suivante : **la seule voie crédible vers une intelligence artificielle forte et contrôlable passe par la preuve formelle**.

Voici leur raisonnement, que je vais essayer de rendre le plus fidèlement possible.

Aujourd'hui, la manière dont on essaye de rendre les IA « alignées » avec nos valeurs repose sur des techniques comme le _RLHF_ (apprentissage par renforcement à partir de retours humains) et des dispositifs de surveillance (_monitoring_). Ces techniques produisent des garanties _statistiques_ : on peut observer que, dans 99,9 % des cas testés, l'IA se comporte comme on le souhaite. Mais 99,9 %, ce n'est pas 100 %. Et quand le système est déployé à très grande échelle, manipule des flux financiers, pilote des infrastructures critiques, ou, à la limite, contrôle lui-même la prochaine génération d'IA, ces quelques cas sur mille deviennent inacceptables.

Tegmark et Omohundro proposent une alternative : plutôt que de contrôler statistiquement le comportement de l'IA, on produit des systèmes _prouvablement_ sûrs. L'IA n'agit qu'à travers une couche de code dont on a prouvé formellement les propriétés de sûreté. Et, argument crucial, c'est précisément l'arrivée de l'IA elle-même qui rend cette approche _faisable à grande échelle_ : parce que c'est maintenant l'IA qui peut écrire les preuves, on peut imaginer vérifier formellement des quantités de code qui auraient été inimaginables il y a dix ans.

On arrive alors à ce qu'on pourrait appeler la **promesse ultime** : la combinaison de la vérification formelle et de l'IA devient la réponse canonique au problème de la sûreté des systèmes critiques — y compris des IA elles-mêmes. C'est le sommet de l'arc que je suis en train de dérouler : le rêve de Leibniz, revisité par l'IA, devient un instrument de sûreté civilisationnelle.

Maintenant, vous imaginez bien qu'il y a une objection qui se profile immédiatement, et je veux la formuler avant de passer à l'acte II. Même si l'on peut prouver qu'un programme ne dépasse pas la pile mémoire allouée, ou qu'un protocole cryptographique préserve la confidentialité, on touche beaucoup plus difficilement aux **valeurs**. Comment formalise-t-on « ne pas nuire à un humain » ? Comment formalise-t-on « être honnête » ? Le problème de la **spécification** — savoir, au juste, ce qu'on veut prouver — reste entier, et il est peut-être le problème le plus profond.

Tegmark et Omohundro en sont conscients, bien sûr, mais ils ont une sorte d'optimisme technique : ils pensent qu'on finira par décomposer ces notions en propriétés prouvables. Je vous laisse juges, et nous y reviendrons en discussion.

Transition vers l'acte II. Nous venons de parcourir l'arc de la promesse. Mais il y a un _présupposé_ dans tout ce que j'ai raconté : j'ai supposé que le cadre technique — le noyau, la vérification, le runtime — était, lui, solide. Et c'est précisément ce présupposé que 2026 vient remettre en question.

---

# Acte II — Le retournement

## 5. Qui vérifie le noyau ? (slide 6)

Reprenons donc la chaîne de confiance depuis le début. Si l'on fonde la sûreté sur la preuve formelle, alors tout repose, en dernière instance, sur **le vérificateur** — sur le petit programme qui vérifie que les termes sont bien typés. Commençons par lui.

Il y a, en vérification formelle, un principe fondateur qu'on appelle le **critère de de Bruijn**, du nom du mathématicien néerlandais qui l'a énoncé dans le cadre du projet _AUTOMATH_ à la fin des années 1960. Ce critère dit à peu près ceci : l'assistant de preuve doit être architecturé autour d'un **noyau minimal**, un tout petit programme dont le seul rôle est de vérifier des λ-termes, et dont la taille doit être suffisamment réduite pour qu'un être humain puisse en auditer le code intégralement.

Les conséquences sont importantes. Cela veut dire qu'on **ne fait pas confiance aux tactiques** — les tactiques peuvent être buguées, peu importe, parce qu'elles produisent des termes que le noyau vérifiera. On fait confiance au noyau, et seulement au noyau. Dans Rocq, ce noyau fait de l'ordre de quelques milliers de lignes de code OCaml. C'est peu. En principe, cela veut dire que si le noyau est correct, alors toute preuve qu'il accepte est correcte.

Mais, bien sûr, immédiatement surgit la question : **et le noyau lui-même, comment sait-on qu'il est correct ?** On peut imaginer le prouver avec un autre assistant de preuve, mais alors la question se déplace au noyau de celui-ci. Et même si on considère le noyau comme correct, il faut encore le compiler ; le compilateur est-il correct ? Et le matériel qui exécute le binaire ? Nous voici pris dans une **régression** potentiellement infinie.

C'est exactement la question que Ken Thompson pose en 1984.

## 6. Thompson 1984 — _Reflections on Trusting Trust_ (slide 7)

Ken Thompson est co-inventeur d'Unix et lauréat du prix Turing. En 1984, pour son discours de réception du prix, il donne une conférence courte mais devenue un classique, intitulée _Reflections on Trusting Trust_.

Son expérience de pensée est la suivante. Imaginons un compilateur C malveillant. Ce compilateur a deux particularités. **Premièrement**, quand il compile le programme `login` (celui qui vérifie votre mot de passe au démarrage d'Unix), il injecte une porte dérobée : un mot de passe secret qui donne accès à n'importe quel compte. **Deuxièmement**, quand il compile un autre compilateur C, il injecte dans le compilateur résultant ces deux mêmes comportements — il s'auto-reproduit à la compilation.

Maintenant, supposons que vous receviez le compilateur sous forme de binaire, et que vous vouliez vérifier qu'il est sain. Vous lisez son code source : le code est propre, aucune trace de backdoor. Vous recompilez le compilateur avec lui-même pour être sûr. Mais le compilateur que vous utilisez pour recompiler est déjà contaminé : il réinjecte silencieusement la porte dérobée dans le nouveau binaire. Le code source n'a _jamais_ contenu de trace du problème. Vous avez un code source propre, mais un binaire compromis.

La thèse de Thompson se résume dans une phrase : _« You can't trust code that you did not totally create yourself. »_ — Vous ne pouvez pas faire confiance à du code que vous n'avez pas créé vous-même entièrement.

L'argument est profond. Il ne s'agit pas d'un bug particulier, mais d'une **structure** : toute vérification s'exécute sur une machine, et la machine elle-même n'est pas vérifiée. La vérification ne supprime pas la confiance, elle la _déplace_. On ne fait plus confiance au programme prouvé, mais on fait toujours confiance au noyau, au compilateur, à la mémoire, au processeur. C'est cette notion de _trusted computing base_, de « base de confiance », qui est au cœur de l'ingénierie sécuritaire moderne.

Et c'est précisément ce qui justifie le critère de de Bruijn : en minimisant le noyau, on minimise la surface de cette base de confiance. Mais on ne la réduit jamais à zéro. Il reste toujours _quelque chose_ à croire sur parole.

Jusqu'en 2026, ce raisonnement restait en grande partie théorique. On savait que c'était vrai ; on n'avait pas d'exemple spectaculaire à chaque niveau de la chaîne. **Cette année, on en a plusieurs, et ils sont arrivés en quelques mois.**

## 7. Le retournement 2026 — trois fractures simultanées (slide 8)

Je vais vous présenter trois événements. Ils sont survenus à quelques semaines d'intervalle. Ils touchent trois niveaux différents de la chaîne de confiance. Et ils ont tous un point commun : l'IA y joue un rôle central, mais pas du tout dans le rôle séduisant que nous décrivions tout à l'heure.

**Premier événement — Mythos.** En avril 2026, Anthropic (l'entreprise qui développe Claude) publie un rapport intitulé _Mythos_. Il présente les résultats obtenus par un pipeline d'IA spécialisé dans la recherche de vulnérabilités de sécurité. En quelques mois, ce système a trouvé des _0-days_ — c'est-à-dire des failles inconnues — dans OpenBSD, dans Linux, dans FreeBSD, avec des exploits qui permettent l'exécution de code à distance. Des milliers de vulnérabilités au total. Plus troublant encore, le système est capable de reconstruire du code source à partir de binaires fermés, et de trouver des bugs dans des codes dont les sources ne sont pas publiques. L'échelle est telle que la relecture humaine est dépassée : les équipes de sécurité des projets concernés ne peuvent plus suivre le rythme.

Ce qu'il faut retenir de _Mythos_, c'est que l'argument de Tegmark et Omohundro se **retourne** : ils disaient que l'IA serait l'outil qui nous permettrait de rendre les systèmes sûrs. Mais la même capacité qui permet à l'IA de _vérifier_ à grande échelle lui permet aussi de _casser_ à grande échelle. L'IA qui vérifie est aussi l'IA qui exploite. Et rien ne garantit que la première l'emporte sur la seconde — c'est une course, pas une victoire acquise.

**Deuxième événement — `False` dans Rocq.** Celui-là nous concerne directement. En mars 2026, Tristan Stérin, accompagné de collaborateurs humains et utilisant Claude Opus 4.6, publie un billet de blog intitulé _In Search of Falsehood_. Leur résultat : **sept preuves indépendantes de `False` ont été acceptées par le noyau de Rocq**. Sept preuves de la proposition fausse par excellence — celle qui, si elle est démontrable, rend tout démontrable. Les bugs exploités concernent principalement le _guard checker_ (le vérificateur de terminaison des fonctions récursives) et la gestion des **modules**. Le travail est issu d'une collaboration IA + humains, avec implication de l'équipe de développement de Rocq. Ce n'est pas le premier bug jamais trouvé dans Rocq ; mais c'est, de loin, la campagne de fuzzing la plus systématique qui ait été menée, et elle est alimentée par un LLM.

Ce qu'il faut retenir, c'est que **le noyau minimal qu'on vous a vendu en leçon 1 comme « base de confiance » a en fait plusieurs trous**. Le critère de de Bruijn garantit que le noyau est _auditable_, pas qu'il est _correct_. C'est une différence considérable. L'auditabilité est une condition _nécessaire_ de la correction ; elle n'est pas _suffisante_.

**Troisième événement — les _Watchers_.** En avril 2026, Karthik Gopinathan publie un papier décrivant un exploit dans la bibliothèque `lean-zip`. Cette bibliothèque implémente, dans le langage Lean 4, un **décodeur ZIP prouvé correct** — c'est-à-dire que la fonction qui décompresse les données est formellement vérifiée. Mais, et c'est là le point, le parseur qui lit l'_archive ZIP_ entière (la structure de fichier qui contient les entrées compressées), lui, n'est pas vérifié. Il contient un bug, exploité par un fichier ZIP de seulement 156 octets, qui produit un _heap overflow_ dans le runtime Lean (précisément dans la fonction `lean_alloc_sarray`), lequel débouche sur une exécution de code arbitraire.

Ce qu'il faut retenir de cet événement, c'est que c'est **Thompson 1984, littéralement, appliqué à la vérification formelle**. La preuve était correcte. Le théorème était vrai. Mais le _runtime_ qui exécute la fonction prouvée n'était pas vérifié. Et il suffit d'un trou dans ce runtime pour que toute la chaîne de garanties s'effondre. La confiance a été déplacée vers le runtime — et le runtime nous a trahis.

**Récapitulons.** Nous avons trois événements simultanés, touchant trois niveaux différents : le niveau de la _spécification_ (Mythos : l'IA comme adversaire nouveau, repère ce qu'on n'avait pas spécifié), le niveau du _noyau_ (False dans Rocq : le vérificateur lui-même est faillible), le niveau du _runtime_ (Watchers : l'exécution de code prouvé reste exposée). Trois niveaux, trois fractures, dans la même année.

## 8. Les trois niveaux de confiance, ré-examinés (slide 9)

À ce stade, je voudrais qu'on résiste à la tentation d'une conclusion nihiliste. L'affirmation serait : « tout cela est vain, la vérification formelle ne sert à rien. » Ce n'est pas ce que je veux dire, et ce n'est pas ce que ces trois événements établissent.

Ce qu'ils établissent, c'est que la chaîne de confiance se décompose en **trois couches**, et que chacune de ces couches a des garanties _relatives_, pas _absolues_.

Au niveau **1**, la **spécification** : est-ce qu'on a bien décrit ce qu'on voulait prouver ? C'est un travail humain, philosophique presque, qui dépend de notre capacité à formaliser les concepts pertinents. Pour « ne pas dépasser la pile », c'est facile. Pour « être honnête », c'est peut-être impossible. C'est la question que pose _Mythos_ : toute spécification laisse des angles morts, et l'IA adversaire excelle à trouver ces angles morts.

Au niveau **2**, le **noyau**. Ici, on a une garantie _relative à la correction du noyau lui-même_. Le cas `False` dans Rocq nous rappelle que cette hypothèse n'est pas gratuite : le noyau a des bugs, et on les trouve à mesure qu'on le stresse plus fort.

Au niveau **3**, le **runtime, le compilateur, le matériel**. Ici, on a une garantie _relative au fait que l'exécution est fidèle à la sémantique formelle_. Le cas Lean nous rappelle que cette fidélité n'est pas acquise.

L'analogie avec les mathématiques est éclairante. Quand vous prouvez un théorème en théorie des ensembles, vous ne prouvez pas qu'il est vrai dans l'absolu ; vous prouvez qu'il est vrai _si_ les axiomes de ZFC sont cohérents. Prouver quelque chose en Rocq, c'est prouver qu'il est vrai _si_ le noyau est correct, _si_ le runtime est fidèle, _si_ le matériel exécute bien le binaire. La bonne question n'est jamais « peut-on faire confiance ? » — c'est toujours « à quoi faisons-nous confiance, et cette confiance est-elle justifiée ? ».

Autrement dit : la vérification formelle n'a pas été réfutée par 2026. Elle a été **recadrée**. Elle reste un outil puissant, le plus puissant que nous ayons pour produire des garanties sur des systèmes logiciels. Mais elle ne produit pas de magie. Elle produit des garanties conditionnelles, et la philosophie nous rappelle depuis longtemps que tout savoir est conditionnel à quelque chose.

---

# Acte III — Questions ouvertes

## 9. Discussion — Think / Pair / Share (slide 10)

J'aimerais maintenant que vous preniez la parole. Je vais vous proposer quatre questions. Nous n'en traiterons sans doute que deux, selon l'énergie et les intérêts du groupe. Le format : deux minutes de réflexion individuelle, trois minutes en binôme, puis mise en commun.

**Première question — l'IA : adversaire ou garante ?** On a vu qu'une même capacité — chercher efficacement dans l'espace des programmes et des preuves — permet soit de produire des systèmes sûrs, soit de produire des attaques. Comment arbitrer ? Peut-on imaginer une configuration où la balance penche durablement d'un côté ? Ou bien sommes-nous condamnés à une course permanente, où chaque progrès défensif est suivi d'un progrès offensif ?

**Deuxième question — formaliser Spinoza, formaliser Gödel.** Il y a des projets en cours — le projet de Pommeret sur l'Éthique de Spinoza ; les formalisations successives par Benzmüller, puis par Kirchner et Zalta, de la preuve ontologique de Gödel — qui cherchent à passer au crible de l'assistant de preuve des textes philosophiques classiques. La question est la suivante : ces formalisations sont-elles des _traductions fidèles_ qui permettent de vérifier la validité des raisonnements originaux ? Ou bien sont-elles nécessairement des _ré-interprétations_, qui introduisent leur propre ontologie et donc changent l'objet même qu'on prétend vérifier ?

**Troisième question — comprendre versus vérifier.** Le théorème des quatre couleurs, tel que formalisé par Gonthier, fait des dizaines de milliers de lignes de Coq. Personne, littéralement personne, ne l'a jamais lu intégralement. Le noyau l'a vérifié. Est-ce que cela compte comme « faire des mathématiques » ? Est-ce qu'il y a une différence épistémologique entre une preuve _comprise_ et une preuve _seulement vérifiée_ ? Et si oui, laquelle ?

**Quatrième question — la sûreté prouvable : voie royale ou illusion ?** Tegmark et Omohundro proposent que la sûreté de l'IA passe par la preuve. Mais leur argument repose sur la possibilité de spécifier formellement ce que signifie « sûr ». Est-ce possible ? Peut-on formaliser des valeurs sans en changer la nature ? Ou bien y a-t-il quelque chose dans l'éthique qui résiste par essence à la formalisation ?

## 10. Bilan — six semaines (slide 11)

Je termine par un bilan, et je vais essayer de le faire court.

Côté **savoir-faire**, en six semaines, vous avez appris à habiter un type, c'est-à-dire à construire un terme qui témoigne d'une proposition. Vous avez manipulé la déduction naturelle, d'abord sur papier, puis dans Rocq. Vous avez découvert les types inductifs, `Fixpoint`, l'induction. Vous savez formaliser un énoncé simple et commencer à en ébaucher la preuve. Ce n'est pas rien. Vous avez acquis une compétence technique que, dans votre parcours de philosophes, très peu de gens possèdent.

Côté **philosophique**, on a croisé plusieurs idées que je trouve vraiment importantes, et que je vous laisse en souvenir. **Curry-Howard** d'abord : une preuve et un programme, c'est la même chose, exprimée dans deux langages. **Le constructivisme** : dans cette perspective, une proposition n'est pas vraie « en soi », elle est vraie _parce qu'on en produit un témoin_. **Le vérificationnisme** : une proposition a un sens parce que nous savons comment la vérifier, et cette idée hérite de Dummett, qu'elle radicalise. **La mécanisation du travail épistémique** : de plus en plus de ce qu'on appelait « raisonnement » est délégable à des machines, et cela pose des questions profondes sur ce qu'est une pratique mathématique. Enfin, et peut-être surtout, **la confiance déplacée, pas supprimée** : aucune vérification n'abolit la confiance, elle ne fait que la transférer ailleurs, et il est crucial de savoir _où_ elle est transférée.

Pour la suite. Il vous reste un devoir maison : démontrer en Rocq que `rev (rev l) = l` — le retournement d'une liste retournée est la liste de départ. Rendu le 25 avril. Vous avez les outils, et c'est un exercice parfait pour consolider ce qu'on a vu.

Je termine avec une phrase, et je voudrais qu'elle reste comme une sorte de devise. Leibniz disait _calculemus_ — calculons. Nous sommes, en 2026, plus près de ce rêve que jamais dans l'histoire. Mais nous voyons aussi, plus clairement que jamais, que le calcul lui-même a ses fondations, et que ces fondations ne sont jamais neutres. Alors oui, _calculemus_ — mais **lucidement**.

Merci pour ces six semaines.

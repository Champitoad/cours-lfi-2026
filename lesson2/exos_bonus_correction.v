Section Tautologies.

Variables (A B C D : Prop).

Lemma tautologie_4 :
  A -> B -> A /\ B.
Proof.
  intros HA HB. split.
  - exact HA.
  - exact HB.
Qed.

Lemma tautologie_5 :
  A -> B -> C -> A /\ (B /\ C).
Proof.
  intros HA HB HC. split.
  - exact HA.
  - split.
    + exact HB.
    + exact HC.
Qed.

Lemma tautologie_6 :
  (A /\ B) -> (C -> A).
Proof.
  intros [HA HB] HC. exact HA.
Qed.

Lemma tautologie_7 :
  (A /\ B) -> (C -> B).
Proof.
  intros [HA HB] HC. exact HB.
Qed.

Lemma tautologie_8 :
  (A /\ B) -> (B /\ A).
Proof.
  intros [HA HB]. split.
  - exact HB.
  - exact HA.
Qed.

Lemma tautologie_9 :
  A -> A \/ B.
Proof.
  intros HA. left. exact HA.
Qed.

Lemma tautologie_10 :
  B -> A \/ B.
Proof.
  intros HB. right. exact HB.
Qed.

Lemma tautologie_11 :
  B -> A \/ (B \/ C).
Proof.
  intros HB. right. left. exact HB.
Qed.

Lemma tautologie_12 :
  A \/ B -> (A -> B) -> B.
Proof.
  intros [HA|HB] HAB.
  - apply HAB. exact HA.
  - exact HB.
Qed.

Lemma tautologie_13 :
  A \/ B -> (B \/ A).
Proof.
  intros [HA|HB].
  - right. exact HA.
  - left. exact HB.
Qed.

Lemma tautologie_14 :
  False -> ~ A.
Proof.
  intros HFalse HA. exact HFalse.
Qed.

Lemma tautologie_15 :
  ~ A -> A -> False.
Proof.
  intros HnA HA. apply HnA. exact HA.
Qed.

Lemma tautologie_16 :
  A -> ~ ~ A.
Proof.
  intros HA HnA. apply HnA. exact HA.
Qed.

Lemma tautologie_17 :
  False -> A.
Proof.
  intros HFalse. exfalso. exact HFalse.
Qed.

Lemma tautologie_18 :
  ~ A -> A -> B.
Proof.
  intros HnA HA. exfalso. apply HnA. exact HA.
Qed.

Lemma tautologie_19 :
  A -> (C -> ~ B) -> (A -> B) -> ~ C.
Proof.
  intros HA HCnB HAB HC. apply HCnB.
  - exact HC.
  - apply HAB. exact HA.
Qed.

Lemma tautologie_20 :
  (A -> B) /\ (A -> ~ B) -> ~ A.
Proof.
  intros [HAB HAnB] HA. apply HAnB.
  - exact HA.
  - apply HAB. exact HA.
Qed.

Lemma tautologie_21 :
  (A \/ ~ B) /\ B -> A.
Proof.
  intros [[HA|HnB] HB].
  - exact HA.
  - exfalso. apply HnB. exact HB.
Qed.

Lemma tautologie_22 :
  ~ A \/ B -> A -> B.
Proof.
  intros [HnA|HB] HA.
  - exfalso. apply HnA. exact HA.
  - exact HB.
Qed.

Lemma tautologie_23 :
  (A -> B) -> (~ B -> ~ A).
Proof.
  intros HAB HnB HA. apply HnB. apply HAB. exact HA.
Qed.

Lemma tautologie_24 :
  A /\ B -> C -> A.
Proof.
  intros [HA HB] HC. exact HA.
Qed.

Lemma tautologie_25 :
  A /\ B -> C -> B /\ C.
Proof.
  intros [HA HB] HC. split.
  - exact HB.
  - exact HC.
Qed.

Lemma tautologie_26 :
  A -> A /\ (A \/ B).
Proof.
  intros HA. split.
  - exact HA.
  - left. exact HA.
Qed.

Lemma tautologie_27 :
  A \/ (B /\ C) -> A \/ B.
Proof.
  intros [HA|[HB HC]].
  - left. exact HA.
  - right. exact HB.
Qed.

Lemma tautologie_28 :
  A \/ B -> (A -> B) -> B.
Proof.
  intros [HA|HB] HAB.
  - apply HAB. exact HA.
  - exact HB.
Qed.

Lemma tautologie_29 :
  (A -> B -> C) -> ((A -> B) -> A -> C).
Proof.
  intros HABC HAB HA. apply HABC.
  - exact HA.
  - apply HAB. exact HA.
Qed.

Lemma tautologie_30 :
  (A -> B -> C) -> A /\ B -> C.
Proof.
  intros HABC [HA HB]. apply HABC.
  - exact HA.
  - exact HB.
Qed.

Lemma tautologie_31 :
  (A -> B) -> (A -> C) -> A -> B /\ C.
Proof.
  intros HAB HAC HA. split.
  - apply HAB. exact HA.
  - apply HAC. exact HA.
Qed.

Lemma tautologie_32 :
  (A -> B) -> A \/ C -> B \/ C.
Proof.
  intros HAB [HA|HC].
  - left. apply HAB. exact HA.
  - right. exact HC.
Qed.

Lemma tautologie_33 :
  (A /\ B) \/ (A \/ B) -> A \/ B.
Proof.
  intros [[HA HB]|[HA|HB]].
  - left. exact HA.
  - left. exact HA.
  - right. exact HB.
Qed.

Lemma tautologie_34 :
  (A -> C) /\ (B -> C) -> A \/ B -> C.
Proof.
  intros [HAC HBC] [HA|HB].
  - apply HAC. exact HA.
  - apply HBC. exact HB.
Qed.

Lemma tautologie_35 :
  ~ A \/ B -> A -> B.
Proof.
  intros [HnA|HB] HA.
  - exfalso. apply HnA. exact HA.
  - exact HB.
Qed.

Lemma tautologie_36 :
  (A -> B -> C) -> A /\ B -> C.
Proof.
  intros HABC [HA HB]. apply HABC.
  - exact HA.
  - exact HB.
Qed.

Lemma tautologie_37 :
  A -> (A -> B) -> ((A -> B) -> (B -> C)) -> C.
Proof.
  intros HA HAB HABC. apply (HABC HAB). apply HAB. exact HA.
Qed.

Lemma tautologie_38 :
  (A /\ B -> C) <-> (A -> B -> C).
Proof.
  split.
  - intros H HA HB. apply H. split.
    + exact HA.
    + exact HB.
  - intros H [HA HB]. apply H.
    + exact HA.
    + exact HB.
Qed.

Lemma tautologie_39 :
  (A \/ B -> C) <-> (A -> C) /\ (B -> C).
Proof.
  split.
  - intros H. split.
    + intros HA. apply H. left. exact HA.
    + intros HB. apply H. right. exact HB.
  - intros [HAC HBC] [HA|HB].
    + apply HAC. exact HA.
    + apply HBC. exact HB.
Qed.

Lemma tautologie_40 :
  A /\ (B /\ C) <-> (A /\ B) /\ C.
Proof.
  split.
  - intros [HA [HB HC]]. split.
    + split.
      * exact HA.
      * exact HB.
    + exact HC.
  - intros [[HA HB] HC]. split.
    + exact HA.
    + split.
      * exact HB.
      * exact HC.
Qed.

Lemma tautologie_41 :
  A \/ (B \/ C) <-> (A \/ B) \/ C.
Proof.
  split.
  - intros [HA|[HB|HC]].
    + left. left. exact HA.
    + left. right. exact HB.
    + right. exact HC.
  - intros [[HA|HB]|HC].
    + left. exact HA.
    + right. left. exact HB.
    + right. right. exact HC.
Qed.

Lemma tautologie_42 :
  A /\ (B -> C) -> A /\ B -> A /\ C.
Proof.
  intros [HA HBC] [_ HB]. split.
  - exact HA.
  - apply HBC. exact HB.
Qed.

Lemma tautologie_43 :
  A /\ (B \/ C) <-> (A /\ B) \/ (A /\ C).
Proof.
  split.
  - intros [HA [HB|HC]].
    + left. split.
      * exact HA.
      * exact HB.
    + right. split.
      * exact HA.
      * exact HC.
  - intros [[HA HB]|[HA HC]].
    + split.
      * exact HA.
      * left. exact HB.
    + split.
      * exact HA.
      * right. exact HC.
Qed.

Lemma tautologie_44 :
  A \/ (B /\ C) <-> (A \/ B) /\ (A \/ C).
Proof.
  split.
  - intros [HA|[HB HC]].
    + split.
      * left. exact HA.
      * left. exact HA.
    + split.
      * right. exact HB.
      * right. exact HC.
  - intros [[HA|HB] [HA'|HC]].
    + left. exact HA.
    + left. exact HA.
    + left. exact HA'.
    + right. split.
      * exact HB.
      * exact HC.
Qed.

Lemma tautologie_45 :
  (A -> B) /\ (A -> C) -> (A -> (B /\ C)).
Proof.
  intros [HAB HAC] HA. split.
  - apply HAB. exact HA.
  - apply HAC. exact HA.
Qed.

Lemma tautologie_46 :
  (A -> (B /\ C)) -> (A -> B) /\ (A -> C).
Proof.
  intros H. split.
  - intros HA. destruct (H HA) as [HB HC]. exact HB.
  - intros HA. destruct (H HA) as [HB HC]. exact HC.
Qed.

Lemma tautologie_47 :
  (A -> B) \/ (A -> C) -> (A -> (B \/ C)).
Proof.
  intros [HAB|HAC] HA.
  - left. apply HAB. exact HA.
  - right. apply HAC. exact HA.
Qed.

Lemma tautologie_48 :
  (A -> (B -> C)) -> ((A -> B) -> (A -> C)).
Proof.
  intros HABC HAB HA. apply HABC.
  - exact HA.
  - apply HAB. exact HA.
Qed.

Lemma tautologie_49 :
  ((A -> B) -> (A -> C)) -> (A -> (B -> C)).
Proof.
  intros H HA HB. apply H.
  - intros _. exact HB.
  - exact HA.
Qed.

Lemma tautologie_50 :
  (A \/ B -> C) <-> (A -> C) /\ (B -> C).
Proof.
  split.
  - intros H. split.
    + intros HA. apply H. left. exact HA.
    + intros HB. apply H. right. exact HB.
  - intros [HAC HBC] [HA|HB].
    + apply HAC. exact HA.
    + apply HBC. exact HB.
Qed.

Axiom LEM : forall A, A \/ ~A.

Lemma tautologie_52 :
  (A -> (B \/ C)) -> (A -> B) \/ (A -> C).
Proof.
  intros H. destruct (LEM A) as [HA|HnA].
  - destruct (H HA) as [HB|HC].
    + left. intros _. exact HB.
    + right. intros _. exact HC.
  - left. intros HA. exfalso. apply HnA. exact HA.
Qed.

Lemma tautologie_53 :
  A \/ ~ A.
Proof.
  apply (LEM A).
Qed.

Lemma tautologie_54 :
  A \/ (A -> B).
Proof.
  destruct (LEM A) as [HA|HnA].
  - left. exact HA.
  - right. intros HA'. exfalso. apply HnA. exact HA'.
Qed.

Lemma tautologie_55 :
  (A -> B) \/ (B -> A).
Proof.
  destruct (LEM A) as [HA|HnA].
  - right. intros _. exact HA.
  - left. intros HA'. exfalso. apply HnA. exact HA'.
Qed.

Lemma tautologie_56 :
  ~ ~ A -> A.
Proof.
  intros HnnA. destruct (LEM A) as [HA|HnA].
  - exact HA.
  - exfalso. apply HnnA. exact HnA.
Qed.

Lemma tautologie_57 :
  ((A -> B) -> A) -> A.
Proof.
  intros H. destruct (LEM A) as [HA|HnA].
  - exact HA.
  - apply H. intros HA'. exfalso. apply HnA. exact HA'.
Qed.

Lemma tautologie_58 :
  ~ ~ (A \/ ~ A).
Proof.
  intros H. apply H. apply (LEM A).
Qed.

Lemma tautologie_59 :
  ~ ~ (A \/ (A -> B)).
Proof.
  intros H. apply H. destruct (LEM A) as [HA|HnA].
  - left. exact HA.
  - right. intros HA'. exfalso. apply HnA. exact HA'.
Qed.

Lemma tautologie_60 :
  ~ ~ ((A -> B) \/ (B -> A)).
Proof.
  intros H. apply H. destruct (LEM A) as [HA|HnA].
  - right. intros _. exact HA.
  - left. intros HA'. exfalso. apply HnA. exact HA'.
Qed.

Lemma tautologie_61 :
  ~ ~ (~ ~ A -> A).
Proof.
  intros H. apply H. intros HnnA. destruct (LEM A) as [HA|HnA].
  - exact HA.
  - exfalso. apply HnnA. exact HnA.
Qed.

Lemma tautologie_62 :
  ~ ~ (((A -> B) -> A) -> A).
Proof.
  intros H. apply H. intros Haba. destruct (LEM A) as [HA|HnA].
  - exact HA.
  - apply Haba. intros HA'. exfalso. apply HnA. exact HA'.
Qed.

End Tautologies.

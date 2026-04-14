Require Import List.
Import ListNotations.

Fixpoint add (n m : nat) : nat :=
  match n with
  | O => m
  | S p => S (add p m)
  end.

Print nat_rect.

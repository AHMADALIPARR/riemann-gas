-- Pattern match for the missing Red2 functor.
-- Wired fields are definitional. identify and preserve are not inhabited.
-- This file does not prove the Riemann hypothesis.

import Mathlib.Data.ZMod.Basic
import Mathlib.Data.Complex.Basic

open Complex

/-- Euler factor, the gas mode. Real s > 1 in the analytic theory. -/
def eulerFactor (p : ℕ) (s : ℂ) : ℂ :=
  1 / (1 - (p : ℂ) ^ (-s))

/-- Carrier of the F2 finite part: vectors over ZMod 2. -/
def FiniteCarrier (g : ℕ) : Type := Fin (2 * g) → ZMod 2

/-- Carrier of the complex finite part used by the HOL script. -/
def ComplexFinite : Type := ℂ

/-- The only pattern that matches on F2: x ↦ x^2 is the identity. -/
theorem f2_square_id (x : ZMod 2) : x ^ 2 = x := ZMod.sq_eq_self x

/-- What Red2 would have to be. The two holes are the assessment's B1 and B2. -/
structure Red2 (g : ℕ) where
  /-- Object map. Not constructed. -/
  map : FiniteCarrier g → (ℂ → ℂ)
  /-- GAP-4: classical zeta is in the image. -/
  identify : Prop
  /-- GAP-3: zeros of the image lie on the critical line. -/
  preserve : Prop

/-- No instance is given. An axiom here would be the hypothesis renamed. -/
def red2_holes_open (g : ℕ) : Prop :=
  ∀ R : Red2 g, R.identify ∧ R.preserve

-- Vendored from SNAPKITTYWEST/dmz-f2-decomposition, with the repairs that matter.
-- Does not prove the Riemann hypothesis.
-- Frobenius and ModularAction are still the identity.
-- Creation/annihilation are nilpotent of index 2g, not of index 2.
-- WeilBound 1 is 5, not 7: Nat division gives 1/2 = 0.

import Mathlib.Algebra.Field.Defs
import Mathlib.Algebra.Module.Basic
import Mathlib.LinearAlgebra.Dimension.Finrank
import Mathlib.FieldTheory.Finite.Basic
import Mathlib.FieldTheory.Finite.GaloisField
import Mathlib.Data.ZMod.Basic
import Mathlib.LinearAlgebra.Matrix.Adjugate
import Mathlib.Algebra.Module.LinearMap.Basic
import Mathlib.Algebra.BigOperators.Group.Finset.Defs
import Mathlib.Algebra.CharP.Two

open Nat ZMod Matrix Fin Polynomial

structure MumfordPair (R : Type*) [CommRing R] where
  u : Polynomial R
  v : Polynomial R
  u_monic : u.Monic
  deg_v_lt_deg_u : v.degree < u.degree
  relation : v ^ 2 + v * u = u ^ 3 + u ^ 2

namespace MumfordPair

noncomputable def zero : MumfordPair (ZMod 2) :=
  { u := 1
    v := 0
    u_monic := Polynomial.monic_one
    deg_v_lt_deg_u := by
      rw [Polynomial.degree_zero, Polynomial.degree_one]
      exact WithBot.bot_lt_coe 0
    relation := by
      rw [zero_pow two_ne_zero, zero_mul, zero_add, one_pow, one_pow, one_add_one_eq_two]
      simp [CharTwo.two_eq_zero] }

end MumfordPair

def JacobianF2 (g : ℕ) : Type := MumfordPair (ZMod 2)

noncomputable def Frobenius (g : ℕ) : JacobianF2 g → JacobianF2 g :=
  fun D =>
    { u := D.u, v := D.v, u_monic := D.u_monic,
      deg_v_lt_deg_u := D.deg_v_lt_deg_u, relation := D.relation }

theorem frobenius_is_identity (g : ℕ) (D : JacobianF2 g) :
    Frobenius g D = D := by
  cases D; rfl

abbrev QuantumSpace (g : ℕ) : Type := Fin (2 * g) → ZMod 2

def CreationOp (g : ℕ) : QuantumSpace g → QuantumSpace g :=
  fun v i =>
    if h : i.val + 1 < 2 * g then v ⟨i.val + 1, h⟩ else 0

def AnnihilationOp (g : ℕ) : QuantumSpace g → QuantumSpace g :=
  fun v i =>
    if h : 0 < i.val then v ⟨i.val - 1, by omega⟩ else 0

def QuantumLaplacian (g : ℕ) : QuantumSpace g → QuantumSpace g :=
  fun v => CreationOp g (AnnihilationOp g v) + AnnihilationOp g (CreationOp g v)

theorem creation_iterate_eq_zero (g n : ℕ) (v : QuantumSpace g)
    (i : Fin (2 * g)) (h : 2 * g ≤ i.val + n) :
    (CreationOp g)^[n] v i = 0 := by
  induction n generalizing i with
  | zero => exact absurd h (by omega)
  | succ n ih =>
      by_cases h1 : i.val + 1 < 2 * g
      · have h2 : 2 * g ≤ (⟨i.val + 1, h1⟩ : Fin (2 * g)).val + n := by
          show 2 * g ≤ i.val + 1 + n
          omega
        have h3 := ih (⟨i.val + 1, h1⟩ : Fin (2 * g)) h2
        simp only [Function.iterate_succ_apply', CreationOp, dite_eq_left h1]
        exact h3
      · simp only [Function.iterate_succ_apply', CreationOp, dite_eq_right h1]

theorem creation_nilpotent (g : ℕ) (v : QuantumSpace g) :
    (CreationOp g)^[2 * g] v = 0 := by
  ext i
  exact creation_iterate_eq_zero g (2 * g) v i (by omega)

theorem annihilation_iterate_eq_zero (g n : ℕ) (v : QuantumSpace g)
    (i : Fin (2 * g)) (h : i.val < n) :
    (AnnihilationOp g)^[n] v i = 0 := by
  induction n generalizing i with
  | zero => exact absurd h (by omega)
  | succ n ih =>
      by_cases h1 : 0 < i.val
      · have h2 : (⟨i.val - 1, by omega⟩ : Fin (2 * g)).val < n := by
          show i.val - 1 < n
          omega
        have h3 := ih (⟨i.val - 1, by omega⟩ : Fin (2 * g)) h2
        simp only [Function.iterate_succ_apply', AnnihilationOp, dite_eq_left h1]
        exact h3
      · simp only [Function.iterate_succ_apply', AnnihilationOp, dite_eq_right h1]

theorem annihilation_nilpotent (g : ℕ) (v : QuantumSpace g) :
    (AnnihilationOp g)^[2 * g] v = 0 := by
  ext i
  exact annihilation_iterate_eq_zero g (2 * g) v i (by omega)

def FinitePart (g : ℕ) : Set (QuantumSpace g) :=
  { v | QuantumLaplacian g v = 0 }

theorem laplacian_kernel_iff (g : ℕ) (v : QuantumSpace g) :
    v ∈ FinitePart g ↔ QuantumLaplacian g v = 0 :=
  Iff.rfl

def CartierManin (g : ℕ) : QuantumSpace g → QuantumSpace g :=
  fun v i => v i ^ 2

theorem zmod_two_sq_eq_self : ∀ x : ZMod 2, x ^ 2 = x := by
  decide

theorem cartier_manin_is_identity (g : ℕ) (v : QuantumSpace g) :
    CartierManin g v = v := by
  ext i
  simp [CartierManin, zmod_two_sq_eq_self]

def ShadowOperator (g : ℕ) : QuantumSpace g → QuantumSpace g :=
  CartierManin g

theorem shadow_equivalence (g : ℕ) : ShadowOperator g = CartierManin g := rfl

def PolarPart (g : ℕ) : Type :=
  Polynomial (ZMod 2) × Polynomial (ZMod 2)

structure JacobiFormF2 (g : ℕ) where
  polar : PolarPart g
  finite : QuantumSpace g
  finite_in_kernel : finite ∈ FinitePart g

def ModularAction (g : ℕ) (γ : Matrix (Fin 2) (Fin 2) (ZMod 2))
    (Z : JacobiFormF2 g) : JacobiFormF2 g :=
  { polar := Z.polar, finite := Z.finite, finite_in_kernel := Z.finite_in_kernel }

theorem modular_invariance (g : ℕ) (γ : Matrix (Fin 2) (Fin 2) (ZMod 2))
    (Z : JacobiFormF2 g) (hγ : γ.det = 1) :
    ModularAction g γ Z = Z := by
  cases Z; rfl

def WeilBound (g : ℕ) : ℕ :=
  2 ^ g + 1 + g * 2 ^ (g / 2 + 1)

theorem weil_bound_exists (g : ℕ) : ∃ bound : ℕ, bound = WeilBound g :=
  ⟨WeilBound g, rfl⟩

theorem weil_bound_genus_one : WeilBound 1 = 5 := by decide

theorem weil_bound_genus_two : WeilBound 2 = 13 := by decide

theorem DMZ_Decomposition_F2 (g : ℕ) (Z : JacobiFormF2 g) :
    (Z.finite ∈ FinitePart g) ∧
    (∀ γ : Matrix (Fin 2) (Fin 2) (ZMod 2), γ.det = 1 → ModularAction g γ Z = Z) ∧
    QuantumLaplacian g Z.finite = 0 ∧
    ShadowOperator g = CartierManin g ∧
    ∃ bound : ℕ, bound = WeilBound g := by
  refine ⟨Z.finite_in_kernel, ?_, ?_, ?_, ?_⟩
  · exact fun γ hγ => modular_invariance g γ Z hγ
  · exact (laplacian_kernel_iff g Z.finite).mp Z.finite_in_kernel
  · exact shadow_equivalence g
  · exact weil_bound_exists g

theorem shadow_and_cartier_are_identity (g : ℕ) (v : QuantumSpace g) :
    ShadowOperator g v = v ∧ CartierManin g v = v :=
  ⟨cartier_manin_is_identity g v, cartier_manin_is_identity g v⟩

theorem operators_nilpotent (g : ℕ) (v : QuantumSpace g) :
    (CreationOp g)^[2 * g] v = 0 ∧
    (AnnihilationOp g)^[2 * g] v = 0 :=
  ⟨creation_nilpotent g v, annihilation_nilpotent g v⟩

#print axioms DMZ_Decomposition_F2
#print axioms creation_nilpotent
#print axioms annihilation_nilpotent
#print axioms weil_bound_genus_one
#print axioms weil_bound_genus_two

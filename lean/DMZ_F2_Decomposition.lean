-- Vendored from
-- https://github.com/SNAPKITTYWEST/dmz-f2-decomposition
-- blob/master/DMZ_F2_Decomposition.lean
-- SHA 7360e34bdd1af0ca98280e2d88b1f4b98fb314b9
--
-- This file does not prove the Riemann hypothesis.
-- Frobenius and ModularAction are defined as the identity, then proved
-- equal to the identity by rfl. WeilBound is a local formula; the existence
-- theorem is that formula equal to itself. The source assessment says the
-- bridge from this F2 data to zeros of zeta(s) is conjectural.

import Mathlib.Algebra.Field.Defs
import Mathlib.Algebra.Module.Basic
import Mathlib.LinearAlgebra.Dimension.Finrank
import Mathlib.FieldTheory.Finite.Basic
import Mathlib.FieldTheory.Finite.GaloisField
import Mathlib.Data.ZMod.Basic
import Mathlib.LinearAlgebra.Matrix.Adjugate
import Mathlib.Algebra.Module.LinearMap.Basic
import Mathlib.Algebra.BigOperators.Group.Finset

open Nat ZMod Matrix Fin Polynomial

structure MumfordPair (R : Type*) [CommRing R] where
  u : Polynomial R
  v : Polynomial R
  u_monic : u.Monic
  deg_v_lt_deg_u : v.degree < u.degree
  relation : v ^ 2 + v * u = u ^ 3 + u ^ 2

namespace MumfordPair

noncomputable def zero (R : Type*) [CommRing R] : MumfordPair R :=
  { u := 1
    v := 0
    u_monic := Polynomial.monic_one
    deg_v_lt_deg_u := by
      simp [Polynomial.degree_zero, Polynomial.degree_one]
    relation := by simp }

end MumfordPair

def JacobianF2 (g : ℕ) : Type* := MumfordPair (ZMod 2)

noncomputable def Frobenius (g : ℕ) : JacobianF2 g → JacobianF2 g :=
  fun D =>
    { u := D.u
      v := D.v
      u_monic := D.u_monic
      deg_v_lt_deg_u := D.deg_v_lt_deg_u
      relation := D.relation }

theorem frobenius_is_identity (g : ℕ) (D : JacobianF2 g) :
    Frobenius g D = D := by
  cases D; rfl

def QuantumSpace (g : ℕ) : Type* := Fin (2 * g) → ZMod 2

def CreationOp (g : ℕ) : QuantumSpace g → QuantumSpace g :=
  fun v i =>
    if h : i.val + 1 < 2 * g
    then v ⟨i.val + 1, h⟩
    else 0

def AnnihilationOp (g : ℕ) : QuantumSpace g → QuantumSpace g :=
  fun v i =>
    if h : 0 < i.val
    then v ⟨i.val - 1, by omega⟩
    else 0

def QuantumLaplacian (g : ℕ) : QuantumSpace g → QuantumSpace g :=
  fun v => CreationOp g (AnnihilationOp g v) + AnnihilationOp g (CreationOp g v)

theorem creation_nilpotent (g : ℕ) (v : QuantumSpace g) :
    CreationOp g (CreationOp g v) = 0 := by
  ext i
  simp only [CreationOp]
  split_ifs with h₁ h₂
  · exact absurd (by omega : i.val + 1 + 1 < 2 * g) (by omega)
  · rfl
  · rfl

theorem annihilation_nilpotent (g : ℕ) (v : QuantumSpace g) :
    AnnihilationOp g (AnnihilationOp g v) = 0 := by
  ext i
  simp only [AnnihilationOp]
  split_ifs with h₁ h₂
  · exact absurd h₂ (by omega)
  · rfl
  · rfl

def FinitePart (g : ℕ) : Set (QuantumSpace g) :=
  { v | QuantumLaplacian g v = 0 }

theorem laplacian_kernel_iff (g : ℕ) (v : QuantumSpace g) :
    v ∈ FinitePart g ↔ QuantumLaplacian g v = 0 :=
  Iff.rfl

def CartierManin (g : ℕ) : QuantumSpace g → QuantumSpace g :=
  fun v i => v i ^ 2

theorem cartier_manin_is_identity (g : ℕ) (v : QuantumSpace g) :
    CartierManin g v = v := by
  ext i
  simp [CartierManin, ZMod.sq_eq_self]

def ShadowOperator (g : ℕ) : QuantumSpace g → QuantumSpace g :=
  CartierManin g

theorem shadow_equivalence (g : ℕ) : ShadowOperator g = CartierManin g := rfl

def PolarPart (g : ℕ) : Type* :=
  Polynomial (ZMod 2) × Polynomial (ZMod 2)

structure JacobiFormF2 (g : ℕ) where
  polar  : PolarPart g
  finite : QuantumSpace g
  finite_in_kernel : finite ∈ FinitePart g

def ModularAction (g : ℕ) (γ : Matrix (Fin 2) (Fin 2) (ZMod 2))
    (Z : JacobiFormF2 g) : JacobiFormF2 g :=
  { polar  := Z.polar
    finite := Z.finite
    finite_in_kernel := Z.finite_in_kernel }

theorem modular_invariance (g : ℕ) (γ : Matrix (Fin 2) (Fin 2) (ZMod 2))
    (Z : JacobiFormF2 g) (hγ : γ.det = 1) :
    ModularAction g γ Z = Z := by
  cases Z; rfl

def WeilBound (g : ℕ) : ℕ :=
  2 ^ g + 1 + g * 2 ^ (g / 2 + 1)

theorem weil_bound_exists (g : ℕ) : ∃ (bound : ℕ), bound = WeilBound g :=
  ⟨WeilBound g, rfl⟩

theorem weil_bound_genus_one : WeilBound 1 = 7 := by native_decide

theorem weil_bound_genus_two : WeilBound 2 = 13 := by native_decide

theorem DMZ_Decomposition_F2 (g : ℕ) (Z : JacobiFormF2 g) :
    Z.finite_in_kernel ∧
    (∀ γ : Matrix (Fin 2) (Fin 2) (ZMod 2), γ.det = 1 → ModularAction g γ Z = Z) ∧
    QuantumLaplacian g Z.finite = 0 ∧
    ShadowOperator g = CartierManin g ∧
    ∃ bound : ℕ, bound = WeilBound g :=
  ⟨Z.finite_in_kernel,
   fun γ hγ => modular_invariance g γ Z hγ,
   Z.finite_in_kernel,
   shadow_equivalence g,
   weil_bound_exists g⟩

theorem shadow_and_cartier_are_identity (g : ℕ) (v : QuantumSpace g) :
    ShadowOperator g v = v ∧ CartierManin g v = v :=
  ⟨cartier_manin_is_identity g v, cartier_manin_is_identity g v⟩

theorem operators_nilpotent (g : ℕ) (v : QuantumSpace g) :
    CreationOp g (CreationOp g v) = 0 ∧
    AnnihilationOp g (AnnihilationOp g v) = 0 :=
  ⟨creation_nilpotent g v, annihilation_nilpotent g v⟩

#check @DMZ_Decomposition_F2
#check @creation_nilpotent
#check @annihilation_nilpotent
#check @shadow_equivalence
#check @frobenius_is_identity
#check @cartier_manin_is_identity
#check @modular_invariance
#check @weil_bound_genus_one
#check @weil_bound_genus_two

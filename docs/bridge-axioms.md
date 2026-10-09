# Axioms and lemmas

Copyright (C) 2026 Prime Materia Commons / Foundry F1 contributors
Copyright (C) 2026 Ahmad Ali Parr

The hypothesis used here is Hilbert–Pólya, as stated for this program: there exists a self-adjoint operator H = H* whose eigenvalues λ_n are the ordinates of zeros ρ_n = 1/2 + iλ_n of ζ(s).

This file does not close the bridge. The hypothesis already writes Re ρ = 1/2 into the correspondence. Deriving the critical line from it is not a construction of H, and it is not a map from the compiled F2 model to ζ.

## Axioms that are theorems elsewhere

- A1. ζ has a simple pole at 1 and trivial zeros at -2, -4, -6, … . Riemann; mathlib `RiemannHypothesis` excludes both.
- A2. Nontrivial zeros lie in 0 < Re s < 1, and are symmetric under s ↔ 1-s and conjugation.
- A3. No zero on Re s = 1. This is the prime-number theorem.
- A4. For Re s > 1, ζ(s) = ∏_p (1 - p^{-s})^{-1}.
- A5. Weil 1948, Deligne 1974 and 1980: the Riemann hypothesis for zeta functions of varieties over finite fields.
- A6. The compiled model blob `7360e34`: Frobenius on Mumford coefficients over ZMod 2 is the identity; Cartier–Manin is x → x^2; `WeilBound` existence is the local formula equal to itself.

## Hypothesis, not an axiom

- H. Hilbert–Pólya, as above. Open. Not discharged by A1–A6.

## Lemmas that follow

- L1. From A4 and the 64-prime truncation: Z_64(s) < ζ(s) for s = 2, 3, 4.
- L2. From A6: Cartier identity and coefficient Frobenius identity over F2.
- L3. From H, if granted: each λ_n is real, so each corresponding ρ_n has real part 1/2. This is the definition of the correspondence, not a new zero.
- L4. From A5: a zero of a curve zeta over a finite field lies on its critical line. The zeta is not ζ(s).

## The bridge lemma, which does not follow

- B. There is a map from the compiled F2 data to the nontrivial zeros of ζ(s) that preserves the critical line.

B does not follow from A1–A6. It does not follow from H: H names an operator, and A6 names an identity on ZMod 2. No clause identifies them. Alloy, on the invariant source, returned a world in which the derived lemmas hold and the Riemann hypothesis is not claimed.

The bridge stays open.

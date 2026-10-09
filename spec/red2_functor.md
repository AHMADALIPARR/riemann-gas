# Red2 pattern match

The missing functor is `Red2`, the map the source assessment calls B1/B2: F2 DMZ data to zeros of `zeta(s)`, preserving the critical line, with `zeta` in the image.

Pattern matching closes only the arrows whose two sides are the same object. It does not close `Red2`.

## Wired

| Left | Right | Why it matches |
|---|---|---|
| Gas mode `z_p(s) = 1/(1-p^{-s})` | Euler factor in the DAG | Same formula, `Re(s) > 1`. |
| `Z_64 = prod_{p in P64} z_p` | Truncated partition in `riemann_gas.py` | Same finite product. Not `zeta`. |
| `JacobiFormF2 = polar ⊕ finite` | HOL `zeta = zeta_polar + zeta_finite` | Same shape: a sum of two named parts. The carriers differ. |
| Lean `finite ∈ ker(QuantumLaplacian)` | HOL `zeta_finite` at a non-trivial zero | Both are called the finite part. One is a vector over `ZMod 2`; the other is a complex value. |
| `CartierManin v i = v i ^ 2` | Identity on `F2` | `ZMod.sq_eq_self`. This is internal to `F2`. |
| Lean `Frobenius` | Identity on Mumford pairs | Defined as the identity, proved by `rfl`. |

## Not wired

| Hole | What a proof would need | Why pattern match fails |
|---|---|---|
| `identify` | A map whose image contains `zeta` | Lean polar part is a pair of polynomials over `ZMod 2`. HOL polar part is a sum of residues of completed zeta. No common carrier. |
| `preserve` | A zero of the image has real part `1/2` | `WeilBound` is a local counting formula. Deligne's theorem is RH for varieties over finite fields. Neither statement mentions a zero of `zeta(s)`. The HOL axiom `|s| = sqrt(2) ⇔ Re s = 1/2` is false. |

## Functor

```text
Red2 : JacobiFormF2 g → (complex → complex)
identify : Red2 Z = zeta          -- hole
preserve : zeta s = 0 → Re s = 1/2 -- hole, and circular if identify is assumed
```

`lean/Red2Functor.lean` inhabits the wired fields and leaves `identify` and `preserve` as conjectures. Filling either by an axiom would restate the hypothesis, not prove it.

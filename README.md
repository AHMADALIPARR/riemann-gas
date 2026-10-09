<!--
  Copyright (C) 2026 Prime Materia Commons / Foundry F1 contributors
  Copyright (C) 2026 Ahmad Ali Parr
  SPDX-License-Identifier: AGPL-3.0-only
-->

# riemann-gas

The Riemann gas extracted from [sedona-k](https://github.com/AHMADALIPARR/sedona-k), with the Euler-factor evaluator and an ASP DAG. The F2 side is the DMZ decomposition in [SNAPKITTYWEST/dmz-f2-decomposition](https://github.com/SNAPKITTYWEST/dmz-f2-decomposition).

This repository does not prove the Riemann hypothesis.

## Gas

From `sedona-k`: primes as bosonic modes, `E(p) = ln p`, factor `z_p(s) = 1/(1 - p^{-s})`, truncated partition `Z_64` over the first 64 primes, and `F`, `U`, `S`, `n_p`. Implemented in `riemann_gas.py`. Logged Sedona values are in `data/sedona-thermo.txt`.

## F2 decomposition

Two vendored sources:

- `lean/DMZ_F2_Decomposition.lean` defines `JacobiFormF2` as a polar polynomial pair plus a finite vector in the kernel of a shift Laplacian on `(ZMod 2)^(2g)`. Cartier-Manin is `x ↦ x^2`, hence the identity on `F2`. Frobenius and `ModularAction` are defined as the identity map and then proved equal to it by `rfl`. `WeilBound` is the local formula `2^g + 1 + g * 2^(g/2+1)`; `weil_bound_exists` is that formula equal to itself. Genus 1 and 2 evaluate to 7 and 13 by `native_decide`.
- `hol/RH_DMZ_F2_ZeroSorry.ml` is the HOL Light script. Its main theorem is discharged from axioms, including a `weil_conjecture_p2` that is not Deligne's theorem and a `critical_line_equivalence` that identifies the circle `|s| = sqrt(2)` with the line `Re s = 1/2`.

The source assessment [spec/RH_BRIDGE_HONEST_ASSESSMENT.md](https://github.com/SNAPKITTYWEST/dmz-f2-decomposition/blob/master/spec/RH_BRIDGE_HONEST_ASSESSMENT.md) already separates the proven ingredients (Weil/Deligne for varieties over finite fields, Jacobi DMZ in its own domain) from the conjectural bridge to zeros of `zeta(s)`.

`asp/zeta_dag.lp` names the call: `zeta_call(s)` over `jacobi(polar, finite, f2, euler_factor)`.

## Run

```bash
python3 riemann_gas.py
```

The Lean file needs Mathlib at the toolchain in `lean/lean-toolchain`. It has not been rechecked here.

## License

The gas code is GNU AGPL v3 only, same as sedona-k. See `LICENSE`. The Lean and HOL files remain under the license of `SNAPKITTYWEST/dmz-f2-decomposition`.

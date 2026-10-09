<!--
  Copyright (C) 2026 Prime Materia Commons / Foundry F1 contributors
  Copyright (C) 2026 Ahmad Ali Parr
  SPDX-License-Identifier: AGPL-3.0-only
-->

# riemann-gas

The Riemann gas (primon gas) extracted from [sedona-k](https://github.com/AHMADALIPARR/sedona-k), with the Euler-factor evaluator and an Answer Set Programming DAG. The decomposition is the DMZ/F2 reduction from [RH_DMZ_F2_ZeroSorry.ml](https://github.com/SNAPKITTYWEST/dmz-f2-decomposition/blob/master/RH_DMZ_F2_ZeroSorry.ml), not an F4 Lie decomposition.

This repository does not prove the Riemann hypothesis.

## What was extracted

From `sedona-k` (`sedona.k`, `run.k`, `logs/run-thermo.txt`):

- Layer-1 constants: Goldilocks prime `18446744069414584321`, fold constant `4294967295`, and `P64`, the first 64 primes (2..311).
- Bosonic modes with energy `E(p) = ln p` and inverse temperature `s > 1`.
- Single-mode factor `z_p(s) = 1 / (1 - p^{-s})`.
- Truncated partition function `Z_64(s) = prod_{p in P64} z_p(s)`.
- Thermodynamics: `ln Z`, `F = -ln(Z)/s`, `U = sum (ln p)/(p^s - 1)`, `S = s(U - F)`, `n_p = 1/(p^s - 1)`.

The ngn/k library is not vendored. The same relations are in `riemann_gas.py`. Logged Sedona values are in `data/sedona-thermo.txt`.

## DMZ / F2

`hol/RH_DMZ_F2_ZeroSorry.ml` is the HOL Light script from `SNAPKITTYWEST/dmz-f2-decomposition`. Its definitions, copied into the DAG, are:

- `zeta s = zeta_polar s + zeta_finite s`
- `zeta_polar s` is the sum of residues of the completed zeta at 0 and 1
- `f2_reduction z = (Re z mod 2, Im z mod 2)`
- `frobenius_eigenvalue s = f2_reduction (zeta_finite s)`

The script's main theorem is discharged from axioms, including `weil_conjecture_p2` and `critical_line_equivalence`. Those two are not the classical theorems they are named after. Deligne's theorem is the Riemann hypothesis for zeta functions of varieties over finite fields, not a statement that a zero Frobenius eigenvalue of this reduction forces `|s| = sqrt(2)`. And `|s| = sqrt(2)` is a circle, not the line `Re s = 1/2`. The source repo says the same thing in [spec/RH_BRIDGE_HONEST_ASSESSMENT.md](https://github.com/SNAPKITTYWEST/dmz-f2-decomposition/blob/master/spec/RH_BRIDGE_HONEST_ASSESSMENT.md): Weil/Deligne and the Jacobi DMZ decomposition are proven in their own domains; the bridge from F2 data to zeros of `zeta(s)` is conjectural.

## What else is here

- `riemann_gas.py` evaluates `Z_64` and the thermodynamic row, and a separate zeta function (series, Euler product, eta continuation, functional equation). `Z_64` is not zeta; the script prints the gap.
- `asp/zeta_dag.lp` names the call: `zeta_call(s)` over `dmz(polar, finite)`, then `f2_reduction`, with the Euler factor as the gas mode. F2 and DMZ here are labels from that script.

## Run

```bash
python3 riemann_gas.py
```

The gas table is stdlib only. The functional-equation factor in a fuller evaluator needs a gamma; this file does not call one.

## License

The gas code is GNU AGPL v3 only, same as sedona-k. See `LICENSE`. The HOL Light file remains under the license of `SNAPKITTYWEST/dmz-f2-decomposition`.

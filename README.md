<!--
  Copyright (C) 2026 Prime Materia Commons / Foundry F1 contributors
  Copyright (C) 2026 Ahmad Ali Parr
  SnapKitty Research Lab
  SPDX-License-Identifier: AGPL-3.0-only
-->

# Riemann gas

[![License: AGPL v3](https://img.shields.io/badge/license-AGPL--3.0--only-blue.svg)](LICENSE)
[![Hypothesis](https://img.shields.io/badge/Riemann%20hypothesis-open-lightgrey.svg)](https://www.claymath.org/millennium/riemann-hypothesis/)
[![Source](https://img.shields.io/badge/gas-sedona--k-444444.svg)](https://github.com/AHMADALIPARR/sedona-k)
[![Model](https://img.shields.io/badge/compiled%20model-7360e34-1f6feb.svg)](https://github.com/SNAPKITTYWEST/dmz-f2-decomposition)

Prime modes, Euler factors, and the thermodynamic table for the first 64 primes. SnapKitty Research Lab. Copyright © 2026 Prime Materia Commons / Foundry F1 contributors and Ahmad Ali Parr.

This repository does not prove the Riemann hypothesis.

## The hypothesis, from the source

Riemann, 1859, defined ζ(s) by the series Σ n^{-s} for real part greater than 1, continued it, and located the non-trivial zeros on the line of real part 1/2. That location is the hypothesis. It is not a theorem.

The statement used here is the one in mathlib, `Mathlib.NumberTheory.LSeries.RiemannZeta`:

```text
RiemannHypothesis :
  ∀ s : ℂ,
    riemannZeta s = 0 →
    (¬ ∃ n : ℕ, s = -2 * (n + 1)) →
    s ≠ 1 →
    s.re = 1 / 2
```

Excluded are the trivial zeros at the negative even integers, and the pole at 1. What remains is the claim. Bombieri's note for the Clay problem records the same claim as open. Weil (1948) and Deligne (1974, 1980) proved the analogue for zeta functions of varieties over finite fields. That is a different zeta.

Nothing in `riemann_gas.py`, the ASP DAG, or the compiled F2 model discharges the quantifiers above.

## The gas

Extracted from [sedona-k](https://github.com/AHMADALIPARR/sedona-k). Each prime p is a bosonic mode of energy ln p. The inverse temperature is s > 1. The mode factor is the Euler factor 1/(1 - p^{-s}). Over the first 64 primes, 2 through 311, the product is Z_64(s), not ζ(s). Free energy, mean energy, entropy, and occupations are the canonical formulae. Logged values are in `data/sedona-thermo.txt`.

```bash
python3 riemann_gas.py
```

## What is cited, not vendored as truth

The compiled F2 model stays at [SNAPKITTYWEST/dmz-f2-decomposition](https://github.com/SNAPKITTYWEST/dmz-f2-decomposition), commit `d36737c4`, blob `7360e34`. Its own assessment separates Weil–Deligne and the Jacobi DMZ theorem from the conjectural bridge to zeros of ζ(s): [spec/RH_BRIDGE_HONEST_ASSESSMENT.md](https://github.com/SNAPKITTYWEST/dmz-f2-decomposition/blob/master/spec/RH_BRIDGE_HONEST_ASSESSMENT.md).

`asp/zeta_dag.lp` names the gas factor and the polar/finite split. Names are not a map of zeros.

## License

GNU AGPL v3 only. See `LICENSE` and `NOTICE`.

<!--
  Copyright (C) 2026 Prime Materia Commons / Foundry F1 contributors
  Copyright (C) 2026 Ahmad Ali Parr
  SPDX-License-Identifier: AGPL-3.0-only
-->

# riemann-gas

The Riemann gas (primon gas) extracted from [sedona-k](https://github.com/AHMADALIPARR/sedona-k), with the Euler-factor evaluator and the Answer Set Programming DAG built alongside it.

The source calls this the Riemann gas. It is not a claim about the Riemann hypothesis.

## What was extracted

From `sedona-k` (`sedona.k`, `run.k`, `logs/run-thermo.txt`, README §3–§4):

- Layer-1 constants: Goldilocks prime `18446744069414584321`, fold constant `4294967295`, and `P64`, the first 64 primes (2..311).
- Bosonic modes with energy `E(p) = ln p` and inverse temperature `s > 1`.
- Single-mode factor `z_p(s) = 1 / (1 - p^{-s})`.
- Truncated partition function `Z_64(s) = prod_{p in P64} z_p(s)`, the length-64 Euler product.
- Thermodynamics: `ln Z`, Helmholtz free energy `F = -ln(Z)/s`, mean energy `U = sum (ln p)/(p^s - 1)`, entropy `S = s(U - F)`, occupations `n_p = 1/(p^s - 1)`.

The ngn/k library is not vendored. The same relations are in `riemann_gas.py`. Logged Sedona values are in `data/sedona-thermo.txt`.

## What was added

- `riemann_gas.py` evaluates `Z_64`, the thermodynamic row, and a separate zeta function (series, Euler product, eta continuation, functional equation). `Z_64` is not zeta; the script prints the gap.
- `asp/zeta_dag.lp` is the DAG used to name the call: `zeta_call(s)` over an F4 decomposition on DMZ, whose third argument is the Euler factor `(1 - p^{-s})^{-1}`. That factor is `z_p(s)` from the gas. The F4 and DMZ nodes are labels from that encoding, not objects defined in sedona-k.

## Run

```bash
python3 riemann_gas.py
```

Requires Python 3. `chi` uses mpmath for the gamma factor in the functional equation. The gas table itself is stdlib only.

## License

GNU AGPL v3 only, same as sedona-k. See `LICENSE`.

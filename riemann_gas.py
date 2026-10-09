#!/usr/bin/env python3
"""Riemann gas extracted from sedona-k, plus a zeta evaluator.

The gas is the bosonic primon model in
https://github.com/AHMADALIPARR/sedona-k :

    E(p) = ln p,  beta = s > 1
    z_p(s) = 1 / (1 - p^{-s})          Euler factor
    Z_64(s) = prod_{p in P64} z_p(s)   truncated partition function
    F = -ln(Z)/s
    U = sum (ln p) / (p^s - 1)
    S = s (U - F)
    n_p = 1 / (p^s - 1)

Z_64 is not zeta. The script prints both and the gap.
SPDX-License-Identifier: AGPL-3.0-only
"""

from __future__ import annotations

import math
from typing import Iterable, Sequence, Union

Number = Union[complex, float, int]

GOLDILOCKS_PRIME = "18446744069414584321"
EPSILON_FOLD = 4294967295

P64: tuple[int, ...] = (
    2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67,
    71, 73, 79, 83, 89, 97, 101, 103, 107, 109, 113, 127, 131, 137, 139, 149,
    151, 157, 163, 167, 173, 179, 181, 191, 193, 197, 199, 211, 223, 227, 229,
    233, 239, 241, 251, 257, 263, 269, 271, 277, 281, 283, 293, 307, 311,
)


def euler_factor(p: int, s: Number) -> complex:
    """Single-mode partition function z_p(s) = (1 - p^{-s})^{-1}."""
    z = s if isinstance(s, complex) else complex(s)
    return 1.0 / (1.0 - p ** (-z))


def partition(primes: Sequence[int], s: float) -> float:
    """Z(s) over the given modes. Real s > 1."""
    if s <= 1.0:
        raise ValueError("Riemann gas partition requires s > 1")
    prod = 1.0
    for p in primes:
        prod *= 1.0 / (1.0 - p ** (-s))
    return prod


def log_z(primes: Sequence[int], s: float) -> float:
    return math.log(partition(primes, s))


def free_energy(primes: Sequence[int], s: float) -> float:
    return -log_z(primes, s) / s


def mean_energy(primes: Sequence[int], s: float) -> float:
    return sum(math.log(p) / (p ** s - 1.0) for p in primes)


def entropy(primes: Sequence[int], s: float) -> float:
    return s * (mean_energy(primes, s) - free_energy(primes, s))


def occupations(primes: Sequence[int], s: float) -> list[float]:
    return [1.0 / (p ** s - 1.0) for p in primes]


def row(primes: Sequence[int], s: float) -> tuple[float, float, float, float, float]:
    lz = log_z(primes, s)
    free = -lz / s
    energy = mean_energy(primes, s)
    return (s, lz, free, energy, s * (energy - free))


def zeta_series(s: Number, terms: int = 10000) -> complex:
    z = s if isinstance(s, complex) else complex(s)
    if z.real <= 1.0:
        raise ValueError("series requires Re(s) > 1")
    return sum(n ** (-z) for n in range(1, terms + 1))


def zeta_euler(s: Number, primes: Iterable[int] = P64) -> complex:
    z = s if isinstance(s, complex) else complex(s)
    if z.real <= 1.0:
        raise ValueError("Euler product requires Re(s) > 1")
    prod = 1.0 + 0.0j
    for p in primes:
        prod *= euler_factor(p, z)
    return prod


def main() -> None:
    print("goldilocks", GOLDILOCKS_PRIME)
    print("epsilon_fold", EPSILON_FOLD)
    print("P64", len(P64), P64[0], P64[-1])
    print("s logZ F U S")
    refs = {2: math.pi ** 2 / 6.0, 3: 1.202056903159594, 4: math.pi ** 4 / 90.0}
    for s in (2.0, 3.0, 4.0):
        print(row(P64, s))
        z64 = partition(P64, s)
        print(f"  Z64({s:g})={z64}  zeta_ref={refs[int(s)]}  gap={refs[int(s)] - z64}")
    print("occupations s=2, first 8", list(zip(P64[:8], occupations(P64, 2.0)[:8])))
    print("euler_factor(2, 2)", euler_factor(2, 2))


if __name__ == "__main__":
    main()

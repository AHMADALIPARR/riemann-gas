# Alloy lambda as an SMT query, not a proof

The Alloy `Lambda` atom is an ordinate. Z3 (SAT) was asked whether the wired DAG plus `H = H*` and a nonempty ordinate entail `identify` and `preserve`.

Result: `wired + not holes_closed` is sat. `identify`, `preserve`, and `claims_critical_zeta` are false in the model, while `H_eq_Hstar` and `ordinate_lam` are true. The wired facts do not entail the holes.

`wired + holes_closed` is also sat. That is consistency, not a proof.

Recursive unfolding of `rho(n) = 1/2 + i lambda(n)` copies the real part written in the constructor. It does not derive it.

Kani 0.65.0 / CBMC 6.7.1 verified three harnesses: a 2x2 integer matrix equal to its transpose, the `p = 2` occupation denominator `p^2 - 1 = 3`, and a cover that `identify && preserve` need not hold. 0 of 34 checks failed. That closes that arithmetic. It does not close Red2 or the Riemann hypothesis.

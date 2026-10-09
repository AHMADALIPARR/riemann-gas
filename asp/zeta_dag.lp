% Riemann gas call over the DMZ/F2 reduction.
% Source of the DMZ/F2 nodes:
%   SNAPKITTYWEST/dmz-f2-decomposition RH_DMZ_F2_ZeroSorry.ml
% zeta s = zeta_polar s + zeta_finite s
% frobenius_eigenvalue s = f2_reduction (zeta_finite s)
% f2_reduction z = (Re z mod 2, Im z mod 2)
% Euler factor (1 - p^(-s))^(-1) is the single-mode partition of the gas.
% This file is a DAG of names. It is not a proof of the Riemann hypothesis.

node(zeta_call, operator).
value(zeta_call, zeta).

node(zeta, operator).
value(zeta, zeta).

node(s, variable).
value(s, s).

node(dmz, operator).
value(dmz, dmz).

node(zeta_polar, operator).
value(zeta_polar, polar).

node(zeta_finite, operator).
value(zeta_finite, finite).

node(f2_reduction, operator).
value(f2_reduction, f2).

node(frobenius, operator).
value(frobenius, frobenius_eigenvalue).

node(euler, operator).
value(euler, euler_factor).

node(inv, operator).
value(inv, inv).

node(sub, operator).
value(sub, sub).

node(one, constant).
value(one, 1).

node(pow, operator).
value(pow, pow).

node(p, variable).
value(p, p).

node(neg, operator).
value(neg, neg).

node(zero, constant).
value(zero, 0).

proposed_edge(zeta_call, s, 1).
proposed_edge(zeta_call, zeta, 2).

proposed_edge(zeta, s, 1).
proposed_edge(zeta, dmz, 2).

proposed_edge(dmz, zeta_polar, 1).
proposed_edge(dmz, zeta_finite, 2).
proposed_edge(dmz, euler, 3).

proposed_edge(zeta_finite, f2_reduction, 1).
proposed_edge(f2_reduction, frobenius, 1).

proposed_edge(euler, inv, 1).
proposed_edge(inv, sub, 1).
proposed_edge(sub, one, 1).
proposed_edge(sub, pow, 2).
proposed_edge(pow, p, 1).
proposed_edge(pow, neg, 2).
proposed_edge(neg, s, 1).
proposed_edge(neg, zero, 2).

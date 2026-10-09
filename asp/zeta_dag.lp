% Riemann zeta via an F4 Lie decomposition over DMZ.
% Call: zeta_call(s)
% Body: f4_decomp(f4, dmz, euler_factor)
% Euler factor: (1 - p^(-s))^(-1)
% That factor is the single-mode partition function of the Riemann gas.

node(zeta_call, operator).
value(zeta_call, zeta).

node(zeta, operator).
value(zeta, zeta).

node(s, variable).
value(s, s).

node(f4_decomp, operator).
value(f4_decomp, f4_decomp).

node(f4, constant).
value(f4, f4).

node(dmz, constant).
value(dmz, dmz).

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
proposed_edge(zeta, f4_decomp, 2).

proposed_edge(f4_decomp, f4, 1).
proposed_edge(f4_decomp, dmz, 2).
proposed_edge(f4_decomp, euler, 3).

proposed_edge(euler, inv, 1).
proposed_edge(inv, sub, 1).
proposed_edge(sub, one, 1).
proposed_edge(sub, pow, 2).
proposed_edge(pow, p, 1).
proposed_edge(pow, neg, 2).
proposed_edge(neg, s, 1).
proposed_edge(neg, zero, 2).

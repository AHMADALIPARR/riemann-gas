% Riemann gas call over the Lean DMZ/F2 objects.
% Source: SNAPKITTYWEST/dmz-f2-decomposition DMZ_F2_Decomposition.lean
% JacobiFormF2 = polar part ⊕ finite part in ker(QuantumLaplacian)
% CartierManin is x |-> x^2, which is id on F2.
% Euler factor (1 - p^(-s))^(-1) is the single-mode partition of the gas.
% Names only. Not a proof of the Riemann hypothesis.

node(zeta_call, operator).
value(zeta_call, zeta).

node(zeta, operator).
value(zeta, zeta).

node(s, variable).
value(s, s).

node(jacobi, operator).
value(jacobi, jacobi_form_f2).

node(polar, operator).
value(polar, polar_part).

node(finite, operator).
value(finite, finite_part).

node(f2, constant).
value(f2, f2).

node(cartier, operator).
value(cartier, cartier_manin).

node(laplacian, operator).
value(laplacian, quantum_laplacian).

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
proposed_edge(zeta, jacobi, 2).

proposed_edge(jacobi, polar, 1).
proposed_edge(jacobi, finite, 2).
proposed_edge(jacobi, f2, 3).
proposed_edge(jacobi, euler, 4).

proposed_edge(finite, laplacian, 1).
proposed_edge(finite, cartier, 2).

proposed_edge(euler, inv, 1).
proposed_edge(inv, sub, 1).
proposed_edge(sub, one, 1).
proposed_edge(sub, pow, 2).
proposed_edge(pow, p, 1).
proposed_edge(pow, neg, 2).
proposed_edge(neg, s, 1).
proposed_edge(neg, zero, 2).

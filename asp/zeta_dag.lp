% Riemann gas call over JacobiFormF2, with Red2 holes left open.
% Wired: euler factor = gas mode; jacobi = polar + finite; cartier on f2.
% Open: identify (image contains zeta), preserve (zeros on Re = 1/2).

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

node(red2, operator).
value(red2, red2).

node(identify, operator).
value(identify, hole).

node(preserve, operator).
value(preserve, hole).

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

proposed_edge(red2, jacobi, 1).
proposed_edge(red2, zeta, 2).
proposed_edge(red2, identify, 3).
proposed_edge(red2, preserve, 4).

proposed_edge(euler, inv, 1).
proposed_edge(inv, sub, 1).
proposed_edge(sub, one, 1).
proposed_edge(sub, pow, 2).
proposed_edge(pow, p, 1).
proposed_edge(pow, neg, 2).
proposed_edge(neg, s, 1).
proposed_edge(neg, zero, 2).

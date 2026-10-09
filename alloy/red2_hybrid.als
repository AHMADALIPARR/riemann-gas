// Hybrid DAG counterexample for the Red2 holes.
// Second connector: Hilbert-Polya, H = H*, eigenvalues lambda_n
// with rho_n = 1/2 + i lambda_n.
// The check asks whether the wired F2/gas facts plus that connector
// force identify and preserve. They do not.

abstract sig Node {}
one sig Zeta, Jacobi, Polar, Finite, Euler, F2, Cartier, H, Lambda extends Node {}

sig Hole { kind: HoleKind }
abstract sig HoleKind {}
one sig Identify, Preserve extends HoleKind {}

sig Edge { src, dst: Node, slot: Int }

one sig Red2 {
  domain: one Jacobi,
  codomain: one Zeta,
  holes: set Hole
}

one sig HilbertPolya {
  operator: one H,
  adjoint: one H,          // H = H* encoded as the same atom
  ordinates: set Lambda,
  claimsCritical: lone Node
}

fact wired {
  some e: Edge | e.src = Jacobi and e.dst = Polar
  some e: Edge | e.src = Jacobi and e.dst = Finite
  some e: Edge | e.src = Jacobi and e.dst = Euler
  some e: Edge | e.src = Finite and e.dst = Cartier
  some e: Edge | e.src = Cartier and e.dst = F2
  HilbertPolya.adjoint = HilbertPolya.operator
}

fact second_connector {
  some e: Edge | e.src = Red2.codomain and e.dst = HilbertPolya.operator
  some HilbertPolya.ordinates
}

// Closing the Lean holes would require both hole kinds inhabited
// and the connector claiming the zeta node. This does not follow.
assert holes_closed {
  Identify in Red2.holes.kind
  Preserve in Red2.holes.kind
  HilbertPolya.claimsCritical = Zeta
}

check holes_closed for 8 Edge, 2 Hole, 1 Red2, 1 HilbertPolya

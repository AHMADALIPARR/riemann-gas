-- CONJECTURAL -- NOT A PROOF OF RH
-- Supersedes the sorry/axiom-True version. The conditional theorems are
-- program_implies_RH from RH_Bridge_Closure.lean.

import RH_Bridge_Closure

open RHBridge

theorem BridgeConjecture (b : F2Bridge)
    (hP1 : RHOn b.f2Zeros)
    (hGAP5 : b.wildRamificationHandled)
    (hGAP6 : b.spectralInterpretationResolved) :
    RiemannHypothesis :=
  program_implies_RH b hP1 hGAP5 hGAP6

theorem ConditionalRH_from_BridgeConjecture
    (h : ∃ b : F2Bridge, RHOn b.f2Zeros ∧ b.wildRamificationHandled ∧
      b.spectralInterpretationResolved) :
    RiemannHypothesis := by
  obtain ⟨b, hP1, hGAP5, hGAP6⟩ := h
  exact program_implies_RH b hP1 hGAP5 hGAP6

#print axioms BridgeConjecture
#print axioms ConditionalRH_from_BridgeConjecture

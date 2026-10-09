(**************************************************************************)
(* RH_DMZ_F2_ZeroSorry.ml                                                *)
(* Vendored from                                                         *)
(* https://github.com/SNAPKITTYWEST/dmz-f2-decomposition                 *)
(* blob/master/RH_DMZ_F2_ZeroSorry.ml                                    *)
(* SHA 8628d91e98f7b4602c3c8b195bb613b91dea81bb                           *)
(*                                                                        *)
(* The theorem below is proved from axioms. It is not a proof of the     *)
(* Riemann hypothesis. See the source repo assessment:                    *)
(* spec/RH_BRIDGE_HONEST_ASSESSMENT.md                                    *)
(* Deligne 1974 is RH for varieties over finite fields, not the axiom    *)
(* weil_conjecture_p2 as written. |s| = sqrt(2) is not Re(s) = 1/2.     *)
(**************************************************************************)

needs "Library/analysis.ml";;
needs "Library/transc.ml";;
needs "Library/floor.ml";;
needs "Multivariate/complex.ml";;
needs "Multivariate/cauchy.ml";;

new_constant("zeta",            `:complex->complex`);;
new_constant("zeta_polar",      `:complex->complex`);;
new_constant("zeta_finite",     `:complex->complex`);;
new_constant("frobenius_eigenvalue", `:complex->complex`);;
new_constant("completed_zeta",  `:complex->complex`);;

let completed_zeta_def = new_definition
  `completed_zeta s =
     cpow (Cx pi) (--s / Cx(&2)) * cgamma (s / Cx(&2)) * zeta s`;;

let dmz_polar_part = new_definition
  `zeta_polar s =
     residue completed_zeta (Cx(&0)) + residue completed_zeta (Cx(&1))`;;

let dmz_finite_part = new_definition
  `zeta_finite s = zeta s - zeta_polar s`;;

let f2_reduction_map = new_definition
  `f2_reduction z = complex(Re z mod &2, Im z mod &2)`;;

let frobenius_action = new_definition
  `frobenius_eigenvalue s = f2_reduction (zeta_finite s)`;;

let zeta_analytic_continuation = new_axiom
  `!s. ~(s = Cx(&0)) /\ ~(s = Cx(&1)) ==>
       (zeta analytic_on {s})`;;

let functional_equation = new_axiom
  `!s. completed_zeta s = completed_zeta (Cx(&1) - s)`;;

let dmz_decomposition = new_axiom
  `!s. zeta s = zeta_polar s + zeta_finite s`;;

let polar_singularities_only = new_axiom
  `!s. ~(s = Cx(&0)) /\ ~(s = Cx(&1)) ==> zeta_polar s = Cx(&0)`;;

let f2_sign_collapse = new_axiom
  `!z. f2_reduction z = f2_reduction (--z)`;;

let weil_conjecture_p2 = new_axiom
  `!s. frobenius_eigenvalue s = Cx(&0) ==> norm s = sqrt(&2)`;;

let critical_line_equivalence = new_axiom
  `!s. norm s = sqrt(&2) <=> Re s = &1 / &2`;;

let polar_vanishes_on_nontrivial = prove
  (`!s. ~(s = Cx(&0)) /\ ~(s = Cx(&1)) ==> zeta_polar s = Cx(&0)`,
   REPEAT GEN_TAC THEN DISCH_TAC THEN
   MATCH_MP_TAC polar_singularities_only THEN
   ASM_REWRITE_TAC[]);;

let finite_nonzero_at_zeros = prove
  (`!s. zeta s = Cx(&0) /\ ~(s = Cx(&0)) /\ ~(s = Cx(&1)) ==>
        zeta_finite s = Cx(&0)`,
   REPEAT GEN_TAC THEN STRIP_TAC THEN
   REWRITE_TAC[dmz_finite_part] THEN
   MP_TAC (SPEC `s:complex` polar_vanishes_on_nontrivial) THEN
   ASM_REWRITE_TAC[] THEN
   SIMP_TAC[COMPLEX_SUB_RZERO] THEN
   ASM_REWRITE_TAC[]);;

let f2_maps_zero_to_zero = prove
  (`!s. zeta_finite s = Cx(&0) ==> frobenius_eigenvalue s = Cx(&0)`,
   GEN_TAC THEN DISCH_TAC THEN
   REWRITE_TAC[frobenius_action; f2_reduction_map] THEN
   ASM_REWRITE_TAC[] THEN
   SIMP_TAC[RE_CX; IM_CX; REAL_MOD_REFL; COMPLEX_EQ] THEN
   REAL_ARITH_TAC);;

let frobenius_magnitude_sqrt2 = prove
  (`!s. frobenius_eigenvalue s = Cx(&0) ==> norm s = sqrt(&2)`,
   GEN_TAC THEN DISCH_TAC THEN
   MATCH_MP_TAC weil_conjecture_p2 THEN
   ASM_REWRITE_TAC[]);;

let magnitude_sqrt2_iff_critical_line = prove
  (`!s. norm s = sqrt(&2) <=> Re s = &1 / &2`,
   GEN_TAC THEN REWRITE_TAC[critical_line_equivalence]);;

let riemann_hypothesis_dmz_f2 = prove
  (`!s. zeta s = Cx(&0) /\ ~(s = Cx(&0)) /\ ~(s = Cx(&1)) ==>
        Re s = &1 / &2`,
   REPEAT GEN_TAC THEN STRIP_TAC THEN
   MP_TAC (SPEC `s:complex` finite_nonzero_at_zeros) THEN
   ASM_REWRITE_TAC[] THEN INTRO_TAC "hfinite" THEN
   MP_TAC (SPEC `s:complex` f2_maps_zero_to_zero) THEN
   ASM_REWRITE_TAC[hfinite] THEN INTRO_TAC "hfrob" THEN
   MP_TAC (SPEC `s:complex` frobenius_magnitude_sqrt2) THEN
   ASM_REWRITE_TAC[hfrob] THEN INTRO_TAC "hnorm" THEN
   MP_TAC (SPEC `s:complex` magnitude_sqrt2_iff_critical_line) THEN
   ASM_REWRITE_TAC[hnorm] THEN
   TAUTO_TAC);;

import Lake
open Lake DSL

package «riemann-gas-dmz»

require mathlib from git
  "https://github.com/leanprover-community/mathlib4.git"

lean_lib «DMZDecomposition» where
  roots := #[`DMZ_F2_Decomposition]

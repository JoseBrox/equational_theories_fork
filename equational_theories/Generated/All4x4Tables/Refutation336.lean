
import Mathlib.Data.Finite.Prod
import equational_theories.Equations.All
import equational_theories.FactsSyntax
import equational_theories.MemoFinOp
import equational_theories.DecideBang

/-!
This file is generated from the following operator table:
[[3,2,3,1],[3,1,3,2],[1,2,1,3],[1,3,1,1]]
-/

set_option linter.unusedVariables false

/-! The magma definition -/
def «All4x4Tables [[3,2,3,1],[3,1,3,2],[1,2,1,3],[1,3,1,1]]» : Magma (Fin 4) where
  op := finOpTable "[[3,2,3,1],[3,1,3,2],[1,2,1,3],[1,3,1,1]]"

/-! The facts -/
@[equational_result]
theorem «Facts from All4x4Tables [[3,2,3,1],[3,1,3,2],[1,2,1,3],[1,3,1,1]]» :
  ∃ (G : Type) (_ : Magma G) (_: Finite G), Facts G [3865] [3659, 3870, 4065, 4270, 4598] :=
    ⟨Fin 4, «All4x4Tables [[3,2,3,1],[3,1,3,2],[1,2,1,3],[1,3,1,1]]», Finite.of_fintype _, by decideFin!⟩

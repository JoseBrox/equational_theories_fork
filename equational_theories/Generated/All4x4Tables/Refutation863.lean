
import Mathlib.Data.Finite.Prod
import equational_theories.Equations.All
import equational_theories.FactsSyntax
import equational_theories.MemoFinOp
import equational_theories.DecideBang

/-!
This file is generated from the following operator table:
[[1,3,3,0,2],[2,3,3,4,1],[2,3,3,4,2],[1,3,3,4,1],[2,3,3,4,2]]
-/

set_option linter.unusedVariables false

/-! The magma definition -/
def «All4x4Tables [[1,3,3,0,2],[2,3,3,4,1],[2,3,3,4,2],[1,3,3,4,1],[2,3,3,4,2]]» : Magma (Fin 5) where
  op := finOpTable "[[1,3,3,0,2],[2,3,3,4,1],[2,3,3,4,2],[1,3,3,4,1],[2,3,3,4,2]]"

/-! The facts -/
@[equational_result]
theorem «Facts from All4x4Tables [[1,3,3,0,2],[2,3,3,4,1],[2,3,3,4,2],[1,3,3,4,1],[2,3,3,4,2]]» :
  ∃ (G : Type) (_ : Magma G) (_: Finite G), Facts G [828, 838] [1426, 3862, 4065, 4599] :=
    ⟨Fin 5, «All4x4Tables [[1,3,3,0,2],[2,3,3,4,1],[2,3,3,4,2],[1,3,3,4,1],[2,3,3,4,2]]», Finite.of_fintype _, by decideFin!⟩

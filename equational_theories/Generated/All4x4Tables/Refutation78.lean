
import Mathlib.Data.Finite.Prod
import equational_theories.Equations.All
import equational_theories.FactsSyntax
import equational_theories.MemoFinOp
import equational_theories.DecideBang

/-!
This file is generated from the following operator table:
[[1,0,0],[1,0,0],[1,1,0]]
-/

set_option linter.unusedVariables false

/-! The magma definition -/
def «All4x4Tables [[1,0,0],[1,0,0],[1,1,0]]» : Magma (Fin 3) where
  op := finOpTable "[[1,0,0],[1,0,0],[1,1,0]]"

/-! The facts -/
@[equational_result]
theorem «Facts from All4x4Tables [[1,0,0],[1,0,0],[1,1,0]]» :
  ∃ (G : Type) (_ : Magma G) (_: Finite G), Facts G [370] [4269, 4272, 4275, 4320] :=
    ⟨Fin 3, «All4x4Tables [[1,0,0],[1,0,0],[1,1,0]]», Finite.of_fintype _, by decideFin!⟩


import equational_theories.AllEquations
import equational_theories.FactsSyntax
import equational_theories.MemoFinOp
import equational_theories.DecideBang

/-!
This file is generated from the following operator table:
[[1, 1, 1, 1], [2, 2, 0, 3], [2, 2, 1, 3], [2, 2, 1, 3]]
-/

set_option linter.unusedVariables false

/-! The magma definition -/
def «FinitePoly [[1, 1, 1, 1], [2, 2, 0, 3], [2, 2, 1, 3], [2, 2, 1, 3]]» : Magma (Fin 4) where
  op := memoFinOp fun x y => [[1, 1, 1, 1], [2, 2, 0, 3], [2, 2, 1, 3], [2, 2, 1, 3]][x.val]![y.val]!

/-! The facts -/
@[equational_result]
theorem «Facts from FinitePoly [[1, 1, 1, 1], [2, 2, 0, 3], [2, 2, 1, 3], [2, 2, 1, 3]]» :
  ∃ (G : Type) (_ : Magma G), Facts G [1, 1647, 1664, 1672, 3306, 3316, 3319] [307, 1668, 1681, 1691, 1718, 1731, 3258, 3268, 3278, 3659, 4272, 4590] :=
    ⟨Fin 4, «FinitePoly [[1, 1, 1, 1], [2, 2, 0, 3], [2, 2, 1, 3], [2, 2, 1, 3]]», by decideFin!⟩
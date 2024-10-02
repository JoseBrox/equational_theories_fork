
import equational_theories.AllEquations
import equational_theories.FactsSyntax
import equational_theories.MemoFinOp
import equational_theories.DecideBang

/-!
This file is generated from the following operator table:
[[2, 1, 0, 1], [2, 2, 1, 1], [2, 2, 2, 2], [2, 2, 3, 2]]
-/

set_option linter.unusedVariables false

/-! The magma definition -/
def «FinitePoly [[2, 1, 0, 1], [2, 2, 1, 1], [2, 2, 2, 2], [2, 2, 3, 2]]» : Magma (Fin 4) where
  op := memoFinOp fun x y => [[2, 1, 0, 1], [2, 2, 1, 1], [2, 2, 2, 2], [2, 2, 3, 2]][x.val]![y.val]!

/-! The facts -/
@[equational_result]
theorem «Facts from FinitePoly [[2, 1, 0, 1], [2, 2, 1, 1], [2, 2, 2, 2], [2, 2, 3, 2]]» :
  ∃ (G : Type) (_ : Magma G), Facts G [1, 11, 109, 111, 371, 414, 436, 440, 842, 843, 845, 1257, 1265, 1271, 1835, 1857, 1861, 3286, 3306, 3315, 3724, 3925, 3928, 4085, 4090, 4093, 4113, 4601, 4623, 4651] [10, 14, 16, 102, 104, 114, 115, 117, 118, 124, 125, 127, 307, 378, 412, 413, 416, 417, 419, 420, 426, 427, 429, 430, 437, 439, 463, 464, 466, 467, 473, 474, 476, 477, 500, 501, 503, 504, 510, 511, 513, 822, 825, 826, 832, 833, 836, 869, 870, 872, 873, 879, 880, 882, 883, 906, 907, 909, 910, 916, 917, 919, 1021, 1023, 1026, 1029, 1035, 1038, 1045, 1048, 1072, 1073, 1075, 1076, 1082, 1083, 1085, 1086, 1109, 1110, 1112, 1113, 1119, 1120, 1122, 1232, 1238, 1275, 1276, 1278, 1279, 1285, 1286, 1288, 1289, 1312, 1313, 1315, 1316, 1322, 1323, 1325, 1833, 1834, 1837, 1838, 1840, 1841, 1847, 1848, 1850, 1851, 1858, 1860, 1884, 1885, 1887, 1888, 1894, 1895, 1897, 1898, 1921, 1922, 1924, 1925, 1931, 1932, 1934, 3254, 3255, 3258, 3259, 3261, 3262, 3268, 3269, 3271, 3272, 3279, 3281, 3308, 3309, 3316, 3318, 3342, 3343, 3345, 3346, 3352, 3353, 3355, 3456, 3664, 3667, 3668, 3674, 3675, 3678, 3726, 3727, 3824, 3863, 3865, 3868, 3871, 3877, 3880, 3887, 3890, 3924, 3931, 3935, 4074, 4080, 4131, 4268, 4269, 4272, 4275, 4276, 4284, 4290, 4293, 4314, 4343, 4380, 4673] :=
    ⟨Fin 4, «FinitePoly [[2, 1, 0, 1], [2, 2, 1, 1], [2, 2, 2, 2], [2, 2, 3, 2]]», by decideFin!⟩
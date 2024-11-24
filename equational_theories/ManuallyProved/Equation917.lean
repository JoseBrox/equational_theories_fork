import equational_theories.Mathlib.Data.List.Defs
import equational_theories.Mathlib.Order.Greedy
import Mathlib.Data.Finset.Order
import Mathlib.Data.List.AList
import Mathlib.Data.Set.Finite.Lattice
import Mathlib.Data.Set.Basic
import Mathlib.Data.Set.Functor
import Mathlib.GroupTheory.FreeGroup.Basic

import equational_theories.FreshGenerator
import equational_theories.Equations.All
import equational_theories.FactsSyntax



namespace Eq917

private abbrev A := FreeGroup Nat

/- Follows
https://leanprover.zulipchat.com/user_uploads/3121/VR_KgPk0rQaGpgjsi24OECXm/1526.pdf
-/

namespace Greedy
noncomputable section
open FreshGenerator

private abbrev x₁ := FreeGroup.of 1
private abbrev x₂ := FreeGroup.of 2
private abbrev x₃ := FreeGroup.of 3
private abbrev x₄ := FreeGroup.of 4
private abbrev x₅ := FreeGroup.of 5
private abbrev x₆ := FreeGroup.of 6

abbrev PreExtension := A → Set A

abbrev fromList (S : List (A × A)) : PreExtension := fun a => {b | (a, b) ∈ S}

structure PreExtension.OK (E : PreExtension) : Prop where
  finite : Set.Finite {x : A × A | x.2 ∈ E x.1}
  func {a} : Set.Subsingleton (E a)
  base : x₁ ∈ E 1
  eq917 {a b c} : b ∈ E a → c ∈ E (b * a⁻¹ * x₁⁻¹) → a⁻¹ ∈ E (c * x₁)
  aux {a b c d} : b ∈ E a → d ∈ E c → b * a⁻¹ = d * c⁻¹ → a = c -- b = d follows from func
  aux' {a b} : b ∈ E a → b * a⁻¹ ≠ x₁⁻¹

abbrev Extension := {E : PreExtension // E.OK}

class Extension1 where
  E : PreExtension
  ok : E.OK
  d : A
  not_def {c} : c ∉ E d

namespace Extension1
variable [Extension1]
def old : Finset A :=
  insert d <| ok.finite.toFinset.biUnion fun (a, b) => {a, b}

theorem mem_old {a b x}
    (h1 : b ∈ E a) (h2 : x ∈ ({a, b} : Finset A)) : x ∈ old := by
  refine Finset.mem_insert_of_mem ?_
  simp only [old, Finset.mem_biUnion, Set.Finite.mem_toFinset, Set.mem_setOf_eq, Prod.exists]
  exact ⟨_, _, h1, h2⟩

@[local aesop safe forward]
theorem old_dom {a b} (h : b ∈ E a) : a ∈ old := mem_old h (by simp)
@[local aesop safe forward]
theorem old_im {a b} (h : b ∈ E a) : b ∈ old := mem_old h (by simp)
@[local aesop safe forward]
theorem old_d : d ∈ old := Finset.mem_insert_self ..
@[local aesop safe forward]
theorem old_x₁ : x₁ ∈ old := by
  apply old_im
  apply ok.base


def c := freshGenerator old

@[local aesop norm simp]
theorem forgetOld_c : forgetOld old c = c := forgetOld_fresh

attribute [local aesop norm simp] forgetOld_old
attribute [local aesop norm simp] MonoidHom.map_mul

@[local aesop safe destruct]
theorem c_ne_1 : c = 1 → False := by unfold c freshGenerator ; simp

@[local aesop safe destruct]
theorem c_ne_1' : 1 = c → False := fun h => c_ne_1 h.symm

-- There should be a simple direct proof, but we can also use the cyclic one
@[local aesop safe destruct]
theorem c_ne_c_inv : c = c⁻¹ → False := FreeGroup.ne_inv_of_ne_one c_ne_1

@[local aesop safe destruct]
theorem c_ne_c_inv' : c⁻¹ = c → False := fun h => c_ne_c_inv h.symm

inductive Relevant : A → Prop
  | mk {a b} : b ∈ E a → d = b * a⁻¹ * x₁⁻¹ → Relevant a

theorem Relevant.unique {a a'} : Relevant a → Relevant a' → a = a'
  | .mk h1 q1, .mk h2 q2 => ok.aux h1 h2 ((mul_left_inj _).mp (q1 ▸ q2))


@[mk_iff]
inductive Next : A → A → Prop
  | base {a b} : b ∈ E a → Next a b
  | new {a b} : a = d → b = c → Next a b
  | extra {a e f} : Relevant a → e = c * x₁ → f = a⁻¹ →  Next e f -- Nicer for pattern matching


abbrev next : PreExtension := fun a => {b | Next a b}

theorem next_func : ∀ {a}, (next a).Subsingleton
  | _, _, .base hb, _, .base hb' => ok.func hb hb'
  | _, _, .new rfl rfl, _, .new rfl rfl=> rfl
  | _, _, .base hb, _,  .new rfl rfl | _, _,  .new rfl rfl, _, .base hb => (not_def hb).elim
  | _, _, .base hb, _, .extra (.mk h q) he rfl | _, _, .extra (.mk h q) he rfl, _, .base hb
  | _, _, .new rfl rfl, _, .extra (.mk h q) he hf | _, _, .extra (.mk h q) he hf, _, .new rfl rfl => by
    exfalso
    apply_fun forgetOld old at he
    aesop
  | _, _, .extra h1 _ rfl, _, .extra h2 _ rfl => by rw [h1.unique h2]


theorem next_eq917 {a b c} : b ∈ next a → c ∈ next (b * a⁻¹ * x₁⁻¹) → a⁻¹ ∈ next (c * x₁)
  | .base h1, .base h2 => .base $ ok.eq917 h1 h2
  | .base h1, .new e rfl => .extra ⟨h1, e.symm⟩ rfl rfl
  | .new rfl rfl, .base he => by
    exfalso
    have := forgetOld_old (old_dom he)
    aesop
  | .new rfl rfl, .extra (.mk h q) he rfl => by
    simp only [mul_assoc, mul_right_inj] at he
    apply (ok.aux' h _).elim
    rw [q] at he
    apply_fun (fun g => x₁⁻¹ * g⁻¹ * x₁) at he
    group at *
    exact he
  | .extra (.mk h1 q1) rfl rfl, .base h2 => by
    group at h2
    have := forgetOld_old (old_dom h2)
    aesop
  | .base h1, .extra (.mk h q) he rfl
  | .new rfl rfl, .new he rfl
  | .extra (.mk h1 q1) rfl rfl, .new he rfl
  | .extra (.mk h1 q1) rfl rfl, .extra (.mk h2 q2) he rfl => by
    exfalso
    apply_fun forgetOld old at he
    aesop


theorem next_aux {a b c d} : b ∈ next a → d ∈ next c → b * a⁻¹ = d * c⁻¹ → a = c
  | .base h1, .base h2, e => ok.aux h1 h2 e
  | .new rfl _, .new rfl _, _ => rfl
  | .base h, .new rfl rfl, he  | .new rfl rfl, .base h, he
  | .base h, .extra (.mk h1 q) rfl rfl, he | .extra (.mk h1 q) rfl rfl, .base h, he
  | .new rfl rfl, .extra (.mk h1 q) rfl rfl, he | .extra (.mk h1 q) rfl rfl, .new rfl rfl, he => by
    exfalso
    apply_fun forgetOld old at he
    aesop
  | .extra h1 rfl rfl, .extra h2 rfl rfl, he => by rw [h1.unique h2] at he

theorem next_aux' {a b} : b ∈ next a → b * a⁻¹ ≠ x₁⁻¹
  | .base h, he => ok.aux' h he
  | .new rfl rfl, he
  | .extra (.mk h1 q) rfl rfl, he => by
    exfalso
    apply_fun forgetOld old at he
    aesop

theorem next_ok : next.OK where
  finite := by
    have : {a | Relevant a}.Subsingleton := fun _ h1 _ h2 => h1.unique h2
    refine (ok.finite.union <| (.insert (d, c)
    (this.finite.map fun a => ((c * x₁),(a⁻¹))))).subset fun (x,y) hx => ?_
    simp only [Set.mem_setOf_eq] at hx
    match hx with
    | .extra h rfl rfl =>
      simp only [Set.union_insert, Set.mem_insert_iff, Prod.mk.injEq, Set.mem_union,
        Set.mem_setOf_eq]
      right
      right
      simp only [Set.fmap_eq_image, Set.mem_image, Set.mem_setOf_eq, Prod.mk.injEq, mul_left_inj,
        mul_right_inj, and_self, Prod.exists, exists_and_right, exists_eq_right]
      exact ⟨_, h, True.intro, rfl⟩
    | .new rfl rfl => tauto
    | .base h => simp [h]
  func {a} := next_func
  base := Next.base ok.base
  eq917 {a b} := next_eq917
  aux {a b c d} := next_aux
  aux' {a b} := next_aux'

end Extension1


variable (e₀ : Extension)

theorem exists_extension :
    ∃ op : A → A,
    (∀ x, op (op ((op x * x⁻¹)*(op 1)⁻¹)*op 1) = x⁻¹) ∧
    (∀ {x y}, y ∈ e₀.1 x → y = op x) := by
  classical
  have ⟨c, hc, h1, h2, h3⟩ := exists_greedy_chain (a := e₀)
    (task := fun x : _  => {e | (e.1 x).Nonempty}) fun ⟨E, ok⟩ d => by
      if h : (E d).Nonempty then exact ⟨_, le_rfl, h⟩ else
      let E1 : Extension1 := { E, ok, d, not_def := fun h' => h ⟨_, h'⟩ }
      exact ⟨⟨E1.next, E1.next_ok⟩, fun _ _ => (.base ·), _, .new rfl rfl⟩
  simp only [Subtype.exists, Prod.forall] at h3
  classical
  choose f hf1 hf2 op hop using h3
  refine ⟨op, fun x => ?_, fun {x y} h => ?_,⟩
  · let S : Finset A := {x, op x * x⁻¹ * x₁⁻¹, 1, op (op x * x⁻¹*(op 1)⁻¹) * op 1}
    have ⟨⟨e, he⟩, le⟩ := hc.directed.finset_le (hι := ⟨⟨_, h1⟩⟩)
      (S.image fun a => ⟨⟨f a, hf1 a⟩, hf2 a⟩)
    replace le a ha := Finset.forall_image.1 le a ha _ (hop a)
    simp only [Finset.mem_insert, Finset.mem_singleton, forall_eq_or_imp, forall_eq, S] at le
    obtain ⟨opx, opopxxinv, op1, opfinal⟩ := le
    have eq : op 1 = x₁ := e.2.func op1 e.2.base
    exact e.2.func opfinal (eq.symm ▸ (e.2.eq917 opx opopxxinv))
  · exact (hf1 ..).func (h2 _ (hf2 x) _ h) (hop ..)


def GreedyMagma (_ : Extension) := A

def f (e₀ : Extension) : A → A := (exists_extension e₀).choose

theorem f_eq917 (e₀ : Extension) : (∀ x, f e₀ (f e₀ ((f e₀ x * x⁻¹)*(f e₀ 1)⁻¹)*f e₀ 1) = x⁻¹) :=
  (exists_extension e₀).choose_spec.1

theorem f_base (e₀ : Extension) :∀ {x y: GreedyMagma e₀}, y ∈ e₀.1 x → y = f e₀ x :=
  (exists_extension e₀).choose_spec.2

def op (e₀ : Extension) (x y : A) : A := f e₀ (y*x⁻¹) * x

noncomputable instance instMagma : Magma (GreedyMagma e₀) where
  op x y:= op e₀ x y

theorem eq917 : Equation917 (GreedyMagma e₀) := by
  intro x y
  repeat rw [Magma.op, instMagma]
  simp only
  repeat rw [op]
  unfold GreedyMagma at *
  have := f_eq917 e₀ (y * x⁻¹)
  symm
  apply_fun (fun g => g * (y * x⁻¹)) at this
  apply eq_of_mul_inv_eq_one
  group at *
  assumption

theorem fromList_ok {S : List (A × A)}
    (func : ∀ a ∈ S, ∀ b ∈ S, a.1 = b.1 → a.2 = b.2 := by decide)
    (base : (1, x₁) ∈ S := by decide)
    (eq1526 : ∀ a ∈ S, ∀ b ∈ S, b.1 = a.2 * a.1⁻¹ * x₁⁻¹ → (b.2*x₁, a.1⁻¹) ∈ S := by decide)
    (aux : ∀ a ∈ S, ∀ b ∈ S, a.2*a.1⁻¹ = b.2*b.1⁻¹ → a.1 = b.1 := by decide)
    (aux' : ∀ a ∈ S, a.2 * a.1⁻¹ ≠ x₁⁻¹ := by decide) :
    (fromList S).OK where
  finite := List.finite_toSet S
  base := base
  func h1 _ h2 := func _ h1 _ h2 rfl
  eq917 h1 h2 := eq1526 _ h1 _ h2 rfl
  aux h1 h2 h3 := aux _ h1 _ h2 h3
  aux' h1 := aux' _ h1

theorem fromList_eval {e : Extension} {S : List (A × A)} (hS : e.1 = fromList S)
    (a b : A) (h : (a, b) ∈ S := by decide) : f e a = b :=
  (f_base e (hS ▸ h)).symm

end
end Greedy

open Greedy

@[equational_result]
theorem not_1629 : ∃ (G : Type) (_ : Magma G), Facts G [917] [1629] := by
  have ⟨e, he⟩ : ∃ e : Extension, e.1 = fromList
    ([(1,x₁),(x₁^2,1),(x₁⁻¹,x₂),(x₂,x₃),(x₃*x₁,x₁)]) :=
    ⟨⟨_, fromList_ok⟩, rfl⟩
  refine ⟨GreedyMagma e, inferInstance, eq917 e, fun h => ?_⟩
  · have := h (1 : A)
    repeat rw [Magma.op, instMagma] at this
    simp only at this
    repeat rw [op] at this
    group at this
    rw [fromList_eval he 1 x₁, fromList_eval he (x₁^(-1)) x₂, fromList_eval he x₂ x₃] at this
    apply Ne.elim _ this
    unfold GreedyMagma -- changes the inequality type, so that decide works
    decide


@[equational_result]
theorem not_2441 : ∃ (G : Type) (_ : Magma G), Facts G [917] [2441] := by
  have ⟨e, he⟩ : ∃ e : Extension, e.1 = fromList
    ([(1,x₁),(x₁^2,1),(x₁⁻¹,x₂),(x₂*x₁,x₃),(x₃⁻¹,x₄)]) :=
    ⟨⟨_, fromList_ok⟩, rfl⟩
  refine ⟨GreedyMagma e, inferInstance, eq917 e, fun h => ?_⟩
  · have := h (1 : A)
    repeat rw [Magma.op, instMagma] at this
    simp only at this
    repeat rw [op] at this
    group at this
    rw [fromList_eval he 1 x₁,fromList_eval he (x₁^(-1)) x₂, fromList_eval he (x₂*x₁) x₃,
    fromList_eval he (x₃^(-1)) x₄] at this
    apply Ne.elim _ this
    unfold GreedyMagma
    decide

end Eq917
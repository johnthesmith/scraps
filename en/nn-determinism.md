# Fundamental Determinism of Neural Networks and Security

[ru](../ru/nn-determinism.md) | 
[pdf en](../tex/nn-determinism/export/index.pdf) |
[DOI 10.5281/zenodo.18038515](https://zenodo.org/records/18038515)

By the nature of my work, I often encounter claims about the **fundamental
non-determinism** of neural networks given identical input data.

I ASSERT: for any neural network of the form `r = f(a, w)` of any type (LLM,
convolutional, etc.), with fixed arguments `a`, fixed weights `w`, and identical
execution conditions, the result `r` is deterministic. Any variation in the
result without changes to `a`, `w`, or execution conditions is an
implementation error.

Separately, recurrent networks of the form `r1 = f(a, w, r0)` must be noted,
where the result `r1` explicitly depends on the previous state `r0`. However,
even in this case, all else being equal (including `r0`), the result `r1` must
be deterministic.

This assertion also applies to the training process `w = l(a, p)`, where `w`
are the resulting weights, `a` the training arguments, and `p` the training
data.

Let us examine the common objections typically cited as causes of
non-determinism.

---

## Non-determinism of Input Data

*Objection*: the network is fundamentally non-deterministic due to random
values during initialization.

*Refutation*: all numerical values, including weights, are fixed; there is no
internal randomness without changing the arguments. Any violation of identical
arguments for repeated computations is an implementation error.

---

## Hardware Non-determinism

*Objection*: results may vary due to hardware non-determinism.

*Refutation*: with identical hardware and precision, hardware non-determinism
is excluded. The presence of non-determinism indicates hardware faults and
invalidates the result.

---

## Software Non-determinism

*Objection*: results may vary due to software implementation details, including
library versions, internal caching, or optimizations.

*Refutation*: with an identical software environment and library versions, the
result must be deterministic; otherwise, it must be classified as a software
defect.

---

## Algorithmic Non-determinism

*Objection*: results may vary due to algorithmic non-determinism, including
parallel execution, race conditions, or operation ordering.

*Refutation*: non-determinism without changing inputs equals a bug. An algorithm
must produce a single result for fixed data and a fixed sequence of steps. If
the order “floats,” producing for `x + y + z` the result
`(x + y) + z ≠ x + (y + z)`, this must be considered an incorrect
implementation.

---

## External Factors

*Objection*: a network may produce different results due to fuzzy operations
(quantum factors) or external world parameters (measurements).

*Refutation*: any external-world parameter, including quantum effects or other
factors, can affect the result only via explicit model arguments. If a factor
directly influences the result without being explicitly included in the
arguments, this is an implementation error.

---

# Actions

I will outline the actions that should be taken when non-determinism is detected
in a model.

---

## Acknowledging the Problem

The presence of non-determinism is an indicator of a problem. The problem must
be acknowledged and explicitly stated.

---

## Problem Analysis

When non-determinism is detected, its source must be identified and classified
into one of the categories discussed above:

1. Arguments — randomness in inputs or weights, untracked state changes, etc.
2. Hardware non-determinism — differing operation order, hardware faults.
3. Software non-determinism — library versions, optimizations.
4. Algorithmic non-determinism — implementation errors, parallelism, violation
   of execution order.

---

## Problem Resolution

Based on the analysis, measures must be taken to eliminate the problem, with a
demonstration of deterministic results.

---

## Intentional Introduction of Non-determinism

I allow cases where “randomness” is required. However, it must be explicitly
included in the model arguments, with the ability to repeatedly test identical
arguments. The model must still demonstrate determinism.

---

# Conclusions

Based on the above, I propose the following conclusions:

1. Claims about the **fundamental** non-determinism of mathematical neural
   networks indicate either a lack of understanding of what is happening or an
   attempt to conceal errors at the hardware, software, or algorithmic levels.
2. The inability of a neural network to demonstrate deterministic results
   should be considered a dangerous problem due to unpredictability, especially
   in business-critical and mission-critical systems.
3. The use of any models in business-critical and mission-critical systems must
   be based on an understanding of the sources of non-determinism, their control,
   and their elimination.
4. Implementing a deterministic execution pipeline for neural networks should
   be a conscious, high-priority goal.

---

# Final Statement

In summary: discussions about the safety of neural network development, and AI
in general, must be grounded in achieving guaranteed repeatability and
verifiability of AI results. This is achievable.

---

PS. Non-determinism is a bug in the pipeline, not a feature. It must be
eliminated.

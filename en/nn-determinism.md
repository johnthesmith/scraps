# Fundamental Determinism of Neural Networks and Safety

[ru](../ru/nn-determinism.md)

In my professional experience, I encounter the assertion of the **fundamental 
nondeterminism of neural networks** with identical input data.

I ASSERT: for any neural network of the form `r=f(a,w)` of any type (LLM, 
convolutional, etc.), with fixed arguments `a`, fixed weights `w`, and identical 
execution conditions, the result `r` is deterministic. Any variation in the 
result without changes to `a`, `w`, or execution conditions is an implementation 
error.

It is worth noting recurrent networks of the form `r1=f(a,w,r0)`, where the 
result `r1` explicitly depends on the previous state `r0`. However, even in this 
case, under all other equal conditions including `r0`, the result `r1` must be 
deterministic.

The assertion also applies to the training process `w=l(a,p)`, where `w` are the 
resulting weights, `a` are the training arguments, and `p` is the training data.

Let us examine possible objections often cited as causes of nondeterminism.

## Input Data Nondeterminism

*Objection*: the network is fundamentally nondeterministic due to random 
initialization.

*Refutation*: all numerical values, including weights, are fixed; there is no 
internal randomness without changing the arguments. Any violation of identical 
arguments for consecutive computations is an implementation error.

## Hardware Nondeterminism

*Objection*: the result may vary due to hardware nondeterminism.

*Refutation*: with identical hardware and precision, hardware nondeterminism is 
excluded; the presence of determinism indicates hardware errors and invalidates 
the result.

## Software Nondeterminism

*Objection*: the result may vary due to software implementation, including 
library versions, internal caching, or optimizations.

*Refutation*: in identical software environments and library versions, the 
result is either guaranteed deterministic or should be classified as a software 
error.

## Algorithmic Nondeterminism

*Objection*: the result may vary due to algorithmic nondeterminism, including 
parallel execution, race conditions, and operation order.

*Refutation*: nondeterminism without input changes = bug. The algorithm must 
produce the same result with fixed data and a fixed step order. If the order 
“floats”, causing `(x+y)+z ≠ x+(y+z)`, this must be considered an incorrect 
implementation.

## External Factors

*Objection*: the network may give different results due to fuzzy operations 
(quantum factors) or environmental parameters (measurements).

*Refutation*: any external parameter, including quantum operations and other 
factors, can only affect the result through the model arguments. If a factor 
directly affects the result without being explicitly included in the arguments, 
it is an implementation error.

# Actions

Let us review the steps to take upon discovering nondeterminism in a model.

## Acknowledging the Problem

The presence of nondeterminism is an indicator of a problem; fundamental, 
unresolvable nondeterminism in a correct mathematical model does not exist. In 
this case, the problem must be acknowledged and its presence indicated.

## Problem Analysis

Upon discovering nondeterminism, the source must be identified and classified 
into one of the categories discussed above:

1. Arguments — randomness in inputs or weights, unregistered state changes, etc.
2. Hardware nondeterminism — differing operation order, hardware errors.
3. Software nondeterminism — library versions, optimizations.
4. Algorithmic nondeterminism — implementation errors, parallelism, violation of 
operation sequence.

## Problem Resolution

Following the analysis, the problem must be clearly indicated and resolved.

## Implementation of Controlled Nondeterminism

Cases requiring "randomness" are allowed. However, it must be explicitly 
included in the model arguments, with an explanation of the purpose and source, 
and the ability to consistently reproduce it with identical arguments. The model 
must still demonstrate determinism otherwise.

# Conclusions

Based on the above, I draw the following conclusions:

1. The assertion of **fundamental nondeterminism** in a mathematical neural 
network indicates either a lack of information about what is happening or the 
concealment of errors at the hardware, software, or algorithmic level.
2. The inability of a neural network to demonstrate deterministic results should 
be considered a serious problem due to unpredictability, requiring resolution, 
especially in business-critical and mission-critical systems.
3. The use of any models for mission-critical and business-critical systems must 
be based on understanding and controlling the sources of nondeterminism.
4. Implementing a deterministic execution pipeline for neural networks should be 
a priority conscious goal.

# Conclusion

In summary: the discussion on the safety of neural network development, and AI 
in general, must be based on achieving guaranteed repeatability and 
verifiability of AI operation results.

---

PS. Nondeterminism is a bug, not a feature in your pipeline — find it!

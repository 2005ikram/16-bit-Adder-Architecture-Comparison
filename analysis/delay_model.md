# Delay Model

## 1. Purpose

Propagation delay is an important performance metric in digital circuit design.

A digital circuit can produce the correct logical result but still be unsuitable for a high-speed system if its outputs take too long to become valid. Therefore, when comparing two architectures that implement the same function, it is important to analyze how signals propagate through the circuit.

This project compares two 16-bit adder architectures:

- 16-bit Ripple Carry Adder (RCA)
- 16-bit Carry Lookahead Adder (CLA)

The objective is to compare their propagation delay using a simplified timing model. The purpose is not to predict the exact physical delay in nanoseconds, but to understand how the architecture and logic structure affect the critical path.

---

## 2. Propagation Delay

### Definition

Propagation delay is the time required for a change at the input of a logic circuit to produce the corresponding change at its output.

A logic gate does not respond instantaneously to an input transition.

### Physical Intuition

Although digital circuits are described using logic values such as 0 and 1, their physical implementation consists of transistors and electrical interconnections.

When a transistor changes state, electrical capacitances associated with circuit nodes must be charged or discharged. This requires a finite amount of time called propagation delay.

In a real circuit, propagation delay depends on several factors:

- Gate type
- CMOS technology
- Fan-in
- Fan-out
- Load capacitance
- Interconnect and routing
- Operating conditions

---

## 3. Why We Need a Timing Model

Real digital circuits can contain a very large number of logic gates. Calculating the exact delay of every transistor and interconnection is not practical during the early architectural design stage.

Instead, engineers use simplified timing models to study how signals propagate through a circuit.

Common timing approaches include:

- Unit-delay model
- RC-based delay model
- Technology-library timing model

This project uses the **unit-delay model**.

The goal is to compare the architecture of the RCA and CLA rather than predict the exact delay of a physical implementation.

---

## 4. Unit-Delay Model

### Assumption

The unit-delay model assumes that every logic operation has the same propagation delay:

**Delay(gate) = τ**

where `τ` represents one unit of propagation delay.

Under this model, every logic operation is treated as having the same delay regardless of gate type, number of inputs, load, or physical implementation.

### Advantages

The unit-delay model makes architectural timing analysis simple enough to perform manually.

It allows us to focus on how the structure of the RCA differs from the structure of the CLA in terms of signal propagation.

### Limitations

The unit-delay model does not represent the exact physical behavior of a real implementation.

Real propagation delay depends on:

- Gate type
- Fan-in
- Fan-out
- Load capacitance
- Routing delay
- Technology
- Operating conditions

Therefore, the results obtained here are normalized delays expressed in units of `τ`.

---

## 5. Arrival-Time Analysis

### 5.1 Arrival Time

Arrival time represents the time at which a signal becomes available at a particular point in a combinational circuit.

For this analysis, primary inputs are assumed to arrive at time zero:

**Arrival(primary input) = 0**

### 5.2 Arrival-Time Equation

For a logic operation with inputs `X₁, X₂, ..., Xₙ`:

**Arrival(Y) = τ + max(Arrival(X₁), Arrival(X₂), ..., Arrival(Xₙ))**

The `max` operation is used because a gate cannot produce a valid output until all of its required inputs have arrived.

For example, if:

**Arrival(A) = 2τ**

and:

**Arrival(B) = 5τ**

then:

**Arrival(Y) = τ + max(2τ, 5τ) = 6τ**

The latest-arriving input determines the arrival time of the output.

### 5.3 Critical Path

The critical path is the longest propagation path from a primary input to a circuit output.

Therefore:

**Total Delay = Maximum Arrival Time of All Outputs**

---

## 6. General Delay Analysis Procedure

The propagation delay of a combinational circuit can be derived using the following procedure:

1. Write the Boolean equations.
2. Select the timing model.
3. Assign arrival times to the primary inputs.
4. Follow the dependency order of the circuit.
5. Apply the arrival-time equation to every intermediate signal.
6. Find the maximum arrival time among all outputs.

For this project:

**Delay(gate) = τ**

and:

**Arrival(output) = τ + max(Arrival of inputs)**

---

# 7. Delay Analysis of Basic Building Blocks

## 7.1 Half Adder

### Boolean Equations

**Sum = A XOR B**

**Carry = A AND B**

### Initial Conditions

**Arrival(A) = 0**

**Arrival(B) = 0**

### Arrival Calculation

**Arrival(Sum) = τ + max(0, 0) = τ**

**Arrival(Carry) = τ + max(0, 0) = τ**

Therefore:

**Total Delay = τ**

---

## 7.2 Full Adder

Define the generate and propagate signals as:

**G = A AND B**

**P = A XOR B**

The outputs are:

**Cout = G OR (P AND Cin)**

**Sum = P XOR Cin**

### Initial Conditions

**Arrival(A) = 0**

**Arrival(B) = 0**

**Arrival(Cin) = 0**

### Generate and Propagate

**Arrival(G) = τ + max(0, 0) = τ**

**Arrival(P) = τ + max(0, 0) = τ**

### Sum

**Arrival(Sum) = τ + max(τ, 0) = 2τ**

### Carry

First:

**Arrival(P AND Cin) = τ + max(τ, 0) = 2τ**

Then:

**Arrival(Cout) = τ + max(τ, 2τ) = 3τ**

Therefore:

**Arrival(Sum) = 2τ**

**Arrival(Cout) = 3τ**

**Total Delay = 3τ**

The carry output determines the critical path of the full adder.

---

# 8. Delay Analysis of the 16-bit Ripple Carry Adder

For every bit:

**Pᵢ = Aᵢ XOR Bᵢ**

**Gᵢ = Aᵢ AND Bᵢ**

The carry equation is:

**Cᵢ₊₁ = Gᵢ OR (Pᵢ AND Cᵢ)**

### Initial Conditions

**Arrival(Aᵢ) = 0**

**Arrival(Bᵢ) = 0**

**Arrival(C₀) = 0**

Therefore:

**Arrival(Pᵢ) = τ**

**Arrival(Gᵢ) = τ**

### Carry Arrival

For `C₁`:

**Arrival(P₀ AND C₀) = τ + max(τ, 0) = 2τ**

**Arrival(C₁) = τ + max(τ, 2τ) = 3τ**

For `C₂`:

**Arrival(P₁ AND C₁) = τ + max(τ, 3τ) = 4τ**

**Arrival(C₂) = τ + max(τ, 4τ) = 5τ**

Therefore:

**Arrival(C₁) = 3τ**

**Arrival(C₂) = 5τ**

**Arrival(C₃) = 7τ**

The general pattern is:

**Arrival(Cₙ) = (2n + 1)τ**

For a 16-bit RCA:

**Arrival(C₁₆) = (2 × 16 + 1)τ = 33τ**

The sum equation is:

**Sumᵢ = Pᵢ XOR Cᵢ**

Therefore:

**Arrival(Sumᵢ) = τ + max(Arrival(Pᵢ), Arrival(Cᵢ))**

For the most significant sum:

**Arrival(Sum₁₅) = 32τ**

while:

**Arrival(C₁₆) = 33τ**

Therefore:

**Total Delay of 16-bit RCA = 33τ**

The long carry chain forms the critical path.

---

# 9. Delay Analysis of the 16-bit Carry Lookahead Adder

The 16-bit CLA is divided into four 4-bit CLA blocks:

- Block 0: bits 0–3
- Block 1: bits 4–7
- Block 2: bits 8–11
- Block 3: bits 12–15

A second-level Lookahead Carry Unit (LCU) generates the carries entering these blocks:

**C₄, C₈, C₁₂, C₁₆**

The important architectural idea is that these block-boundary carries are calculated from group information instead of waiting for the carry to ripple through every previous bit.

---

## 9.1 Bit Generate and Propagate

For every bit:

**Pᵢ = Aᵢ XOR Bᵢ**

**Gᵢ = Aᵢ AND Bᵢ**

Therefore:

**Arrival(Pᵢ) = τ**

**Arrival(Gᵢ) = τ**

---

## 9.2 Group Propagate

For a 4-bit block:

**PG = P₃P₂P₁P₀**

Therefore:

**Arrival(PG) = τ + max(τ, τ, τ, τ) = 2τ**

---

## 9.3 Group Generate

For a 4-bit block:

**GG = G₃ + P₃G₂ + P₃P₂G₁ + P₃P₂P₁G₀**

The product terms have the following arrival times:

**Arrival(G₃) = τ**

**Arrival(P₃G₂) = 2τ**

**Arrival(P₃P₂G₁) = 2τ**

**Arrival(P₃P₂P₁G₀) = 2τ**

Therefore:

**Arrival(GG) = τ + max(τ, 2τ, 2τ, 2τ) = 3τ**

Thus:

**Arrival(PG) = 2τ**

**Arrival(GG) = 3τ**

---

# 10. Lookahead Carry Unit

The LCU generates the block-boundary carries.

For the first block:

**C₄ = GG₀ + PG₀C₀**

For the second block:

**C₈ = GG₁ + PG₁GG₀ + PG₁PG₀C₀**

For the third block:

**C₁₂ = GG₂ + PG₂GG₁ + PG₂PG₁GG₀ + PG₂PG₁PG₀C₀**

For the fourth block:

**C₁₆ = GG₃ + PG₃GG₂ + PG₃PG₂GG₁ + PG₃PG₂PG₁GG₀ + PG₃PG₂PG₁PG₀C₀**

---

## 10.1 Arrival of C₄

**Arrival(GG₀) = 3τ**

**Arrival(PG₀C₀) = τ + max(2τ, 0) = 3τ**

Therefore:

**Arrival(C₄) = τ + max(3τ, 3τ) = 4τ**

---

## 10.2 Arrival of C₈

The three terms have arrival times:

- `GG₁ = 3τ`
- `PG₁GG₀ = 4τ`
- `PG₁PG₀C₀ = 3τ`

Therefore:

**Arrival(C₈) = τ + max(3τ, 4τ, 3τ) = 5τ**

---

## 10.3 Arrival of C₁₂

The four terms have arrival times:

- `GG₂ = 3τ`
- `PG₂GG₁ = 4τ`
- `PG₂PG₁GG₀ = 4τ`
- `PG₂PG₁PG₀C₀ = 3τ`

Therefore:

**Arrival(C₁₂) = τ + max(3τ, 4τ, 4τ, 3τ) = 5τ**

---

## 10.4 Arrival of C₁₆

The terms of `C₁₆` have maximum arrival time `4τ`.

Therefore:

**Arrival(C₁₆) = τ + 4τ = 5τ**

Thus:

| Carry | Arrival |
|---|---:|
| C₄ | 4τ |
| C₈ | 5τ |
| C₁₂ | 5τ |
| C₁₆ | 5τ |

---

# 11. Local Carry Generation

After the LCU generates the incoming carry for each 4-bit block, the internal carries are generated locally using the standard 4-bit CLA carry equations.

For a block beginning at bit `j`:

**Cⱼ₊₁ = Gⱼ + PⱼCⱼ**

**Cⱼ₊₂ = Gⱼ₊₁ + Pⱼ₊₁Gⱼ + Pⱼ₊₁PⱼCⱼ**

**Cⱼ₊₃ = Gⱼ₊₂ + Pⱼ₊₂Gⱼ₊₁ + Pⱼ₊₂Pⱼ₊₁Gⱼ + Pⱼ₊₂Pⱼ₊₁PⱼCⱼ**

These equations allow the internal carries to be calculated directly from the incoming block carry and the generate/propagate signals of that block.

---

## 11.1 Block 0

The incoming carry is:

**Arrival(C₀) = 0**

Using the local CLA equations:

**Arrival(C₁) = 3τ**

**Arrival(C₂) = 3τ**

**Arrival(C₃) = 3τ**

The LCU generates:

**Arrival(C₄) = 4τ**

---

## 11.2 Block 1

The incoming carry is:

**Arrival(C₄) = 4τ**

Using the local 4-bit CLA equations:

**Arrival(C₅) = 6τ**

**Arrival(C₆) = 6τ**

**Arrival(C₇) = 6τ**

The LCU independently generates:

**Arrival(C₈) = 5τ**

Notice that `C₈` does not wait for `C₅`, `C₆`, or `C₇`.

---

## 11.3 Block 2

The incoming carry is:

**Arrival(C₈) = 5τ**

Therefore:

**Arrival(C₉) = 7τ**

**Arrival(C₁₀) = 7τ**

**Arrival(C₁₁) = 7τ**

The LCU independently generates:

**Arrival(C₁₂) = 5τ**

---

## 11.4 Block 3

The incoming carry is:

**Arrival(C₁₂) = 5τ**

Therefore:

**Arrival(C₁₃) = 7τ**

**Arrival(C₁₄) = 7τ**

**Arrival(C₁₅) = 7τ**

The LCU generates:

**Arrival(C₁₆) = 5τ**

---

# 12. Carry Arrival Summary

| Carry | Arrival Time |
|---|---:|
| C₀ | 0τ |
| C₁ | 3τ |
| C₂ | 3τ |
| C₃ | 3τ |
| C₄ | 4τ |
| C₅ | 6τ |
| C₆ | 6τ |
| C₇ | 6τ |
| C₈ | 5τ |
| C₉ | 7τ |
| C₁₀ | 7τ |
| C₁₁ | 7τ |
| C₁₂ | 5τ |
| C₁₃ | 7τ |
| C₁₄ | 7τ |
| C₁₅ | 7τ |
| C₁₆ | 5τ |

---

# 13. Sum Arrival Times

Each sum is calculated using:

**Sumᵢ = Pᵢ XOR Cᵢ**

Therefore:

**Arrival(Sumᵢ) = τ + max(Arrival(Pᵢ), Arrival(Cᵢ))**

Since:

**Arrival(Pᵢ) = τ**

the sum arrival times are:

| Sum | Arrival Time |
|---|---:|
| Sum₀ | 2τ |
| Sum₁ | 4τ |
| Sum₂ | 4τ |
| Sum₃ | 4τ |
| Sum₄ | 5τ |
| Sum₅ | 7τ |
| Sum₆ | 7τ |
| Sum₇ | 7τ |
| Sum₈ | 6τ |
| Sum₉ | 8τ |
| Sum₁₀ | 8τ |
| Sum₁₁ | 8τ |
| Sum₁₂ | 6τ |
| Sum₁₃ | 8τ |
| Sum₁₄ | 8τ |
| Sum₁₅ | 8τ |

The latest sum outputs arrive at:

**8τ**

while:

**Arrival(C₁₆) = 5τ**

Therefore:

**Total Delay of 16-bit CLA = 8τ**

The critical path is associated with the later sum outputs.

---

# 14. RCA vs CLA

| Feature | 16-bit RCA | 16-bit CLA |
|---|---:|---:|
| Total Delay | 33τ | 8τ |
| Carry Strategy | Sequential propagation | Hierarchical lookahead |
| Architecture | 16-stage carry chain | Four 4-bit CLA blocks + LCU |
| Critical Path | Carry chain | Local carry + sum logic |

Under the unit-delay model:

**RCA = 33τ**

**CLA = 8τ**

The CLA therefore has a significantly shorter modeled critical path.

---

# 15. Why the CLA Is Faster

The RCA and CLA perform the same arithmetic operation, but their carry dependencies are organized differently.

In the RCA:

**C₀ → C₁ → C₂ → C₃ → ... → C₁₆**

Each carry depends on the previous carry. Therefore, the carry must propagate through a long chain of logic.

The CLA reorganizes this dependency using generate and propagate signals.

At the bit level:

**Pᵢ = Aᵢ XOR Bᵢ**

**Gᵢ = Aᵢ AND Bᵢ**

These signals are combined into group signals:

**PG = Group Propagate**

**GG = Group Generate**

The LCU uses these group signals to generate:

**C₄, C₈, C₁₂, C₁₆**

The internal carries are then generated locally inside each 4-bit CLA block.

Therefore, the CLA replaces a long sequential carry dependency with additional lookahead logic and hierarchical carry generation.

The trade-off is increased hardware and logic complexity in exchange for a shorter critical path.

---

# 16. Limitations of the Unit-Delay Model

The results in this analysis are based on a simplified timing abstraction.

The model does not account for:

- Different delays of different gate types
- Fan-in-dependent delay
- Fan-out-dependent delay
- Load capacitance
- Routing delay
- FPGA routing resources
- ASIC technology libraries
- Process variation
- Voltage variation
- Temperature variation

Therefore:

**RCA = 33τ**

and:

**CLA = 8τ**

should not be interpreted as exact physical delays in nanoseconds.

They represent the architectural delay predicted by the chosen unit-delay model.

A real implementation would require technology-specific timing information and Static Timing Analysis (STA).

---

# 17. Key Takeaways

- Real logic gates have finite propagation delay.
- A timing model allows circuit delay to be analyzed without transistor-level simulation.
- The unit-delay model assigns one delay unit, `τ`, to each logic operation.
- Arrival-time analysis provides a systematic method for propagating timing information through a combinational circuit.
- The latest-arriving input determines the arrival time of a gate output.
- The longest propagation path determines the critical path.
- In the RCA, carry information propagates sequentially from one bit to the next.
- The 16-bit RCA has a modeled delay of `33τ`.
- The 16-bit CLA uses four 4-bit CLA blocks and a Lookahead Carry Unit.
- The LCU generates the block-boundary carries `C₄`, `C₈`, `C₁₂`, and `C₁₆`.
- The internal carries are generated locally using the 4-bit CLA carry equations.
- The 16-bit CLA has a modeled critical delay of `8τ` under the assumptions used in this analysis.
- The CLA demonstrates how additional logic can be used to reduce the critical path of an arithmetic circuit.

The main architectural lesson is:

> The CLA achieves a shorter delay by replacing the long sequential carry dependency of the RCA with additional lookahead logic and hierarchical carry generation.

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

In a real circuit, propagation delay depends on:

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

The goal is to compare the architecture of the RCA and CLA rather than predict the exact delay of a physical chip.

---

## 4. Unit-Delay Model

### Assumption

The unit-delay model assumes that every logic operation has the same propagation delay.

```text
Delay(gate) = tau

---
where tau represents one unit of propagation delay.

Under this model, every logic operation is treated as having the same delay regardless of gate type, number of inputs, load, or physical implementation.

Advantages

The unit-delay model makes architectural timing analysis simple enough to perform manually.

It allows us to focus on how the structure of the RCA differs from the structure of the CLA in terms of signal propagation.

Limitations

The unit-delay model does not represent the exact physical behavior of a real implementation.

Real propagation delay depends on:

Gate type
Fan-in
Fan-out
Load capacitance
Routing delay
Technology
Operating conditions

Therefore, the results obtained here are normalized delays expressed in units of tau.

5. Arrival-Time Analysis
5.1 Arrival Time

Arrival time represents the time at which a signal becomes available at a particular point in a combinational circuit.

For this analysis, primary inputs are assumed to arrive at time zero.

Arrival(primary input) = 0
5.2 Arrival-Time Equation

For a logic operation with inputs X1, X2, ..., Xn:

Arrival(Y) = tau + max(Arrival(X1), Arrival(X2), ..., Arrival(Xn))

The max operation is used because a gate cannot produce a valid output until all of its required inputs have arrived.

For example:

Arrival(A) = 2tau
Arrival(B) = 5tau

Then:

Arrival(Y) = tau + max(2tau, 5tau)
           = 6tau

The latest-arriving input determines the arrival time of the output.

5.3 Critical Path

The critical path is the longest propagation path from a primary input to a circuit output.

Therefore:

Total Delay = maximum arrival time of all outputs
6. General Delay Analysis Procedure

The propagation delay of a combinational circuit can be derived using the following procedure:

Write the Boolean equations.
Select the timing model.
Assign arrival times to the primary inputs.
Follow the dependency order of the circuit.
Apply the arrival-time equation to every intermediate signal.
Find the maximum arrival time among all outputs.

For this project:

Delay(gate) = tau

and:

Arrival(output) = tau + max(arrival times of inputs)
7. Delay Analysis of Basic Building Blocks
7.1 Half Adder
Boolean Equations
Sum   = A XOR B
Carry = A AND B
Initial Conditions
Arrival(A) = 0
Arrival(B) = 0
Arrival Calculation
Arrival(Sum) = tau + max(0, 0)
             = tau


Arrival(Carry) = tau + max(0, 0)
               = tau

Therefore:

Total Delay = tau
7.2 Full Adder

Define:

G = A AND B
P = A XOR B

The outputs are:

Cout = G OR (P AND Cin)
Sum  = P XOR Cin
Initial Conditions
Arrival(A) = 0
Arrival(B) = 0
Arrival(Cin) = 0
Generate and Propagate
Arrival(G) = tau + max(0, 0)
           = tau


Arrival(P) = tau + max(0, 0)
           = tau
Sum
Arrival(Sum) = tau + max(tau, 0)
             = 2tau
Carry

First:

Arrival(P AND Cin) = tau + max(tau, 0)
                   = 2tau

Then:

Arrival(Cout) = tau + max(tau, 2tau)
             = 3tau

Therefore:

Arrival(Sum) = 2tau
Arrival(Cout) = 3tau


Total Delay = 3tau

The carry output determines the critical path of the full adder.

8. Delay Analysis of the 16-bit Ripple Carry Adder

For every bit:

P(i) = A(i) XOR B(i)
G(i) = A(i) AND B(i)

The carry equation is:

C(i+1) = G(i) OR (P(i) AND C(i))
Initial Conditions
Arrival(A(i)) = 0
Arrival(B(i)) = 0
Arrival(C0) = 0

Therefore:

Arrival(P(i)) = tau
Arrival(G(i)) = tau
Carry Arrival

For C1:

Arrival(P0 AND C0) = tau + max(tau, 0)
                   = 2tau


Arrival(C1) = tau + max(tau, 2tau)
            = 3tau

For C2:

Arrival(P1 AND C1) = tau + max(tau, 3tau)
                   = 4tau


Arrival(C2) = tau + max(tau, 4tau)
            = 5tau

Therefore:

Arrival(C1) = 3tau
Arrival(C2) = 5tau
Arrival(C3) = 7tau

The general pattern is:

Arrival(Cn) = (2n + 1)tau

For a 16-bit RCA:

Arrival(C16) = (2(16) + 1)tau
             = 33tau

The sum equation is:

Sum(i) = P(i) XOR C(i)

so:

Arrival(Sum(i)) = tau + max(Arrival(P(i)), Arrival(C(i)))

For the most significant sum:

Arrival(Sum15) = 32tau

while:

Arrival(C16) = 33tau

Therefore:

Total Delay of 16-bit RCA = 33tau

The long carry chain is the critical path.

9. Delay Analysis of the 16-bit Carry Lookahead Adder

The 16-bit CLA is divided into four 4-bit CLA blocks:

Block 0: bits 0-3
Block 1: bits 4-7
Block 2: bits 8-11
Block 3: bits 12-15

A second-level Lookahead Carry Unit (LCU) generates the carries entering these blocks:

C4
C8
C12
C16

The important idea is that these block-boundary carries are calculated from group information rather than waiting for the carry to ripple through every previous bit.

9.1 Bit Generate and Propagate

For every bit:

P(i) = A(i) XOR B(i)
G(i) = A(i) AND B(i)

Therefore:

Arrival(P(i)) = tau
Arrival(G(i)) = tau
9.2 Group Propagate

For a 4-bit block:

PG = P3 P2 P1 P0

Therefore:

Arrival(PG) = tau + max(tau, tau, tau, tau)
            = 2tau
9.3 Group Generate

For a 4-bit block:

GG = G3
   + P3G2
   + P3P2G1
   + P3P2P1G0

The product terms have arrival times:

Arrival(G3) = tau


Arrival(P3G2) = 2tau


Arrival(P3P2G1) = 2tau


Arrival(P3P2P1G0) = 2tau

Therefore:

Arrival(GG) = tau + max(tau, 2tau, 2tau, 2tau)
            = 3tau

Thus:

Arrival(PG) = 2tau
Arrival(GG) = 3tau
10. Lookahead Carry Unit

The LCU generates the block-boundary carries.

For the first block:

C4 = GG0 + PG0 C0

For the second block:

C8 = GG1 + PG1 GG0 + PG1 PG0 C0

For the third block:

C12 = GG2
    + PG2 GG1
    + PG2 PG1 GG0
    + PG2 PG1 PG0 C0

For the fourth block:

C16 = GG3
    + PG3 GG2
    + PG3 PG2 GG1
    + PG3 PG2 PG1 GG0
    + PG3 PG2 PG1 PG0 C0
10.1 Arrival of C4
Arrival(GG0) = 3tau


Arrival(PG0 C0)
    = tau + max(2tau, 0)
    = 3tau

Therefore:

Arrival(C4)
    = tau + max(3tau, 3tau)
    = 4tau
10.2 Arrival of C8

The three terms have arrival times:

GG1             = 3tau
PG1 GG0         = 4tau
PG1 PG0 C0      = 3tau

Therefore:

Arrival(C8)
    = tau + max(3tau, 4tau, 3tau)
    = 5tau
10.3 Arrival of C12

The four terms have arrival times:

3tau
4tau
4tau
3tau

Therefore:

Arrival(C12)
    = tau + max(3tau, 4tau, 4tau, 3tau)
    = 5tau
10.4 Arrival of C16

The latest term has an arrival time of 4tau.

Therefore:

Arrival(C16)
    = tau + 4tau
    = 5tau

Thus:

C4  = 4tau
C8  = 5tau
C12 = 5tau
C16 = 5tau
11. Local Carry Generation

After the LCU generates the incoming carry for each 4-bit block, the 4-bit CLA generates the internal carries locally.

For a block starting at bit j:

C(j+1) = G(j) + P(j)C(j)
C(j+2) = G(j+1)
       + P(j+1)G(j)
       + P(j+1)P(j)C(j)
C(j+3) = G(j+2)
       + P(j+2)G(j+1)
       + P(j+2)P(j+1)G(j)
       + P(j+2)P(j+1)P(j)C(j)

These equations allow the internal carries to be generated directly from the incoming block carry and the generate/propagate signals of the block.

11.1 Block 0

The incoming carry is:

Arrival(C0) = 0

Therefore:

Arrival(C1) = 3tau
Arrival(C2) = 3tau
Arrival(C3) = 3tau

The LCU generates:

Arrival(C4) = 4tau
11.2 Block 1

The incoming carry is:

Arrival(C4) = 4tau

Using the local 4-bit CLA equations:

Arrival(C5) = 6tau
Arrival(C6) = 6tau
Arrival(C7) = 6tau

The LCU independently generates:

Arrival(C8) = 5tau

Notice that C8 does not wait for C5, C6, or C7.

11.3 Block 2

The incoming carry is:

Arrival(C8) = 5tau

Therefore:

Arrival(C9)  = 7tau
Arrival(C10) = 7tau
Arrival(C11) = 7tau

The LCU independently generates:

Arrival(C12) = 5tau
11.4 Block 3

The incoming carry is:

Arrival(C12) = 5tau

Therefore:

Arrival(C13) = 7tau
Arrival(C14) = 7tau
Arrival(C15) = 7tau

The LCU generates:

Arrival(C16) = 5tau
12. Carry Arrival Summary
Carry	Arrival
C0	0tau
C1	3tau
C2	3tau
C3	3tau
C4	4tau
C5	6tau
C6	6tau
C7	6tau
C8	5tau
C9	7tau
C10	7tau
C11	7tau
C12	5tau
C13	7tau
C14	7tau
C15	7tau
C16	5tau
13. Sum Arrival Times

Each sum is calculated using:

Sum(i) = P(i) XOR C(i)

Therefore:

Arrival(Sum(i))
    = tau + max(Arrival(P(i)), Arrival(C(i)))

Since:

Arrival(P(i)) = tau

the sum arrival times are:

Sum0  = 2tau
Sum1  = 4tau
Sum2  = 4tau
Sum3  = 4tau


Sum4  = 5tau
Sum5  = 7tau
Sum6  = 7tau
Sum7  = 7tau


Sum8  = 6tau
Sum9  = 8tau
Sum10 = 8tau
Sum11 = 8tau


Sum12 = 6tau
Sum13 = 8tau
Sum14 = 8tau
Sum15 = 8tau

Therefore, the latest sum outputs arrive at:

8tau

while:

Arrival(C16) = 5tau

Hence:

Total Delay of 16-bit CLA = 8tau

The critical outputs are the later sum outputs.

14. RCA vs CLA
Feature	16-bit RCA	16-bit CLA
Total Delay	33tau	8tau
Carry Strategy	Sequential propagation	Hierarchical lookahead
Architecture	16-stage carry chain	Four 4-bit CLA blocks + LCU
Critical Path	Carry chain	Local carry + sum logic

The modeled delays are:

RCA = 33tau
CLA = 8tau

Under the unit-delay model, the CLA therefore has a significantly shorter critical path.

15. Why the CLA Is Faster

The RCA and CLA perform the same arithmetic operation, but their carry dependencies are organized differently.

In the RCA:

C0 -> C1 -> C2 -> C3 -> ... -> C16

Each carry depends on the previous carry.

The CLA reorganizes this dependency using generate and propagate information.

At the 4-bit level:

P(i) = A(i) XOR B(i)
G(i) = A(i) AND B(i)

These are combined into:

PG = group propagate
GG = group generate

The LCU uses PG and GG to calculate the carries entering the four blocks:

C4
C8
C12
C16

The internal carries are then generated locally inside each 4-bit CLA block.

Thus, the CLA replaces a long sequential dependency chain with additional lookahead logic and hierarchical carry generation.

The trade-off is increased hardware and logic complexity in exchange for a shorter critical path.

16. Limitations of the Unit-Delay Model

The results in this analysis are based on an abstraction.

The model does not account for:

Different delays of different gate types
Fan-in-dependent delay
Fan-out-dependent delay
Load capacitance
Routing delay
FPGA routing resources
ASIC technology libraries
Process variation
Voltage variation
Temperature variation

Therefore:

RCA = 33tau
CLA = 8tau

should not be interpreted as exact physical delays in nanoseconds.

They represent the architectural delay predicted by the chosen unit-delay model.

## 12. Key Takeaways

- Propagation delay is a fundamental performance metric in digital design.
- Arrival-time analysis provides a systematic method for calculating circuit delay.
- The Ripple Carry Adder has a linear delay because every carry depends on the previous stage.
- The Carry Lookahead Adder computes carries in parallel, significantly reducing the critical path.
- Although simplified, the Unit Delay Model correctly predicts how the delay scales with circuit size.

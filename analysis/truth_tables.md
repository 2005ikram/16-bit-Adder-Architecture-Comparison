# Truth Tables

## Purpose

Truth tables describe the behavior of a digital circuit by listing every possible input combination and the corresponding outputs.

They are the starting point for deriving Boolean equations and designing digital hardware.

---

## 1. Half Adder

### Inputs

- A
- B

### Outputs

- Sum (S)
- Carry (C)

| A | B | S | C |
|---|---|---|---|
| 0 | 0 | 0 | 0 |
| 0 | 1 | 1 | 0 |
| 1 | 0 | 1 | 0 |
| 1 | 1 | 0 | 1 |

Observation:

- Sum = A XOR B
- Carry = A AND B

---

## 2. Full Adder

### Inputs

- A
- B
- Cin

### Outputs

- Sum (S)
- Carry (Cout)

| A | B | Cin | S | Cout |
|---|---|-----|---|------|
|0|0|0|0|0|
|0|0|1|1|0|
|0|1|0|1|0|
|0|1|1|0|1|
|1|0|0|1|0|
|1|0|1|0|1|
|1|1|0|0|1|
|1|1|1|1|1|

Observation:

- The Sum is 1 when an odd number of inputs are 1.
- Carry is 1 when at least two inputs are 1.

---

## 3. Generate (G)

| A | B | G |
|---|---|---|
|0|0|0|
|0|1|0|
|1|0|0|
|1|1|1|

Observation:

A stage generates a carry only when A = 1 and B = 1.

G = A · B

---

## 4. Propagate (P)

| A | B | P |
|---|---|---|
|0|0|0|
|0|1|1|
|1|0|1|
|1|1|0|

Observation:

A stage propagates an incoming carry when exactly one input is 1.

P = A XOR B

---

## Summary

| Signal | Meaning |
|---------|---------|
| S | Sum output |
| Cout | Carry output |
| G | Generate a carry |
| P | Propagate an incoming carry |
---

# From a 1-bit Full Adder to a 16-bit Adder

The purpose of the previous truth tables is to describe the behavior of a **single stage** of an adder. A 16-bit adder is not designed by creating one large truth table with 32 inputs. Instead, it is built by connecting sixteen identical 1-bit Full Adders together.

Each Full Adder receives:

- One bit from operand A (`Ai`)
- One bit from operand B (`Bi`)
- The carry from the previous stage (`Cin`)

and produces:

- The sum bit (`Si`)
- The carry to the next stage (`Cout`)

Therefore, the same Full Adder truth table is reused sixteen times to construct a complete 16-bit adder.

Creating a truth table for the entire 16-bit adder would require **32 input variables** (16 bits of A and 16 bits of B). The number of possible input combinations would therefore be:

\[
2^{32}=4,294,967,296
\]

which is impractical to write or analyze.

For this reason, digital designers derive and verify the behavior of a **single Full Adder** and then replicate it to build larger arithmetic circuits.

It is important to note that both the **Ripple Carry Adder (RCA)** and the **Carry Lookahead Adder (CLA)** use exactly the same 1-bit Full Adder behavior. The difference between the two architectures is **not** how each bit is added, but **how the carry signal is computed and distributed** between stages.

## Key Takeaways

- A 16-bit adder is built from sixteen identical 1-bit Full Adders.
- The Full Adder truth table is the mathematical foundation of larger adders.
- A complete 16-bit truth table would require \(2^{32}\) input combinations.
- Ripple Carry and Carry Lookahead differ only in the carry generation method, not in the arithmetic operation performed by each bit.

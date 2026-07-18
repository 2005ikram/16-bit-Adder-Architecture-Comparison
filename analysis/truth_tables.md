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

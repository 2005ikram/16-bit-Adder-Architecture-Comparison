# Boolean Derivation
## Purpose

After defining the behavior of digital circuits using truth tables, the next step is to derive the Boolean equations that describe this behavior mathematically.

These equations form the foundation of digital hardware because every logic gate and every arithmetic circuit can be implemented directly from Boolean expressions.

In this chapter, the Boolean equations of the Half Adder, Full Adder, and Carry Lookahead Adder are derived step by step from their corresponding truth tables.
## Design Flow

Every combinational digital circuit follows the same engineering process:

```text
Truth Table
      ↓
Boolean Expression
      ↓
Boolean Simplification
      ↓
Logic Gates
      ↓
Digital Circuit
```

The goal of Boolean derivation is to convert the logical behavior of a circuit into mathematical expressions that can later be implemented using logic gates.
# Half Adder

## Truth Table

| A | B | S | C |
|---|---|---|---|
|0|0|0|0|
|0|1|1|0|
|1|0|1|0|
|1|1|0|1|

## Sum Derivation

Rows where **S = 1**:

- (0,1) → A'B
- (1,0) → AB'

Therefore,
$$
\[
S=A'B+AB'
\]
$$
Using the XOR identity,
$$
\[
S=A\oplus B
\]
$$
## Carry Derivation

Rows where **C = 1**:

- (1,1) → AB

Therefore,
$$
\[
C=A\cdot B
\]
$$
## Key Takeaways

- Sum is implemented using an XOR gate.
- Carry is implemented using an AND gate.
   
 # Full Adder

## Purpose

Derive the Boolean equations of the Full Adder.

## Sum Derivation

Rows where **S = 1**:

- (0,0,1)
- (0,1,0)
- (1,0,0)
- (1,1,1)

Therefore,
$$
\[
S=A'B'Cin+A'BCin'+AB'Cin'+ABCin
\]
$$
This simplifies to
$$
\[
S=A\oplus B\oplus Cin
\]
$$
## Carry Derivation

Rows where **Cout = 1**:

- (0,1,1)
- (1,0,1)
- (1,1,0)
- (1,1,1)

Therefore,
$$
\[
C_{out}=A'BCin+AB'Cin+ABCin'+ABCin
\]
$$
Simplifying,
$$
\[
C_{out}=AB+ACin+BCin
\]
$$
## Key Takeaways

- Sum is the XOR of the three inputs.
- Carry is generated when at least two inputs are 1.
# Generate Signal

## Purpose

Derive the Generate signal used by the Carry Lookahead Adder.

Rows where **G = 1**:

- (1,1)

Therefore,
$$
\[
G=A\cdot B
\]
$$
## Key Takeaways

- Generate depends only on A and B.
- It produces a carry without requiring an input carry.
# Propagate Signal

## Purpose

Derive the Propagate signal.

Rows where **P = 1**:

- (0,1)
- (1,0)

Therefore,
$4
\[
P=A'B+AB'
\]
$$
Using the XOR identity,
$$
\[
P=A\oplus B
\]
$$
## Key Takeaways

- Propagate depends only on A and B.
- It passes an incoming carry to the next stage.   
  
  
 






































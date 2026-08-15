# 16-bit Adder Architecture Comparison 
A verilog-based comparison of two 16-bit adder architectures:
Rippla Carry Adder(RCA16) and Carry Lookahead Adder(CLA16).
## Objectives 
-Implement basic adder building blocks .
-Compare their timing using a Unit Delay Model.
-Verification using simulation.
## Tools
-Verilog
-Icarus Verilog
-GTKWave 
-Git
-Github
## Architectures 
| Architecture|Main Characteristic|
|---|---|
|RCA16|Sequential carry propagation|
|CLA16|Lookahead carry computation|
## Timing Result 
Under the Unit Delay Model:
|Architecture|Delay|
|---|---:|
|RCA16|33τ|
|CLA16|8τ|
The CLA16 achives a shorter theoritical critical path at the cost of additional logic complexity.
## Simulation
The adders were functionally simulated using Icarus Verilog.
Waveforms were inspected using GTKWave.


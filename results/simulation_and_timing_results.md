# Simulation and Timing Results 
## 1.Functional Simulation 
The full Adder,RCA16,and CLA16 were simulated using Icarus Verilog.
The testbenches were used to verify the functional behavior of the implemented architectures.
Waveforms were inspected using GTKWave.
### Waveform 
![Fulll_Adder Waveform](results/figures/full_adder_waveform.png)
Additional waveform results :
RCA16 :`[RCA16_waveform]
CLA16 :`[cla16_waveform]
## 2.Timing Analysis
The timing comparison uses the Unit Delay Model described in the project documentation .
|Architecture|Total Delay|
|---|---:|
|RCA16|33τ|
|CLA16|8τ|
The RCA16 critical path is dominated by the sequential carry chain,while the CLA16 uses lookahead logic to calculate carries more efficiently.
The Unit Delay Model is a simplified theoretical timing model and does not represent physical transistor-level or fabrication timing.
## 3.Main Observation
Under the adopted Unit Delay Model,the CLA16 has a shorter critical path than the RCA16.
The improvement comes at the cost of additional carry-lookahead logic and greater structural complexity.

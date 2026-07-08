@echo off
echo ==========================================
echo Creating 16-bit Adder Project Structure...
echo ==========================================

:: Root files
type nul > README.md
type nul > LICENSE
type nul > .gitignore
type nul > CHANGELOG.md

:: Folders
mkdir docs
mkdir rtl
mkdir tb
mkdir analysis
mkdir simulation
mkdir waveforms
mkdir images
mkdir results
mkdir references
mkdir report

:: Documentation
type nul > docs\theory.md
type nul > docs\mathematics.md
type nul > docs\architecture.md
type nul > docs\design-decisions.md
type nul > docs\verification.md
type nul > docs\timing-analysis.md
type nul > docs\complexity-analysis.md
type nul > docs\engineering-journal.md
type nul > docs\future-work.md

:: RTL
type nul > rtl\half_adder.v
type nul > rtl\full_adder.v
type nul > rtl\ripple16.v
type nul > rtl\cla4.v
type nul > rtl\cla16.v
type nul > rtl\top_comparison.v

:: Testbenches
type nul > tb\tb_half_adder.v
type nul > tb\tb_full_adder.v
type nul > tb\tb_ripple16.v
type nul > tb\tb_cla4.v
type nul > tb\tb_cla16.v

:: Analysis
type nul > analysis\truth_tables.md
type nul > analysis\boolean_derivation.md
type nul > analysis\karnaugh_maps.md
type nul > analysis\graph_model.md
type nul > analysis\delay_model.md
type nul > analysis\complexity_proof.md
type nul > analysis\probability_analysis.md
type nul > analysis\optimization.md

:: Results
type nul > results\simulation_results.md
type nul > results\timing_results.md
type nul > results\comparison_table.md
type nul > results\discussion.md
type nul > results\conclusions.md

:: References
type nul > references\books.md
type nul > references\papers.md
type nul > references\websites.md

:: Report
type nul > report\report.docx
type nul > report\report.pdf

echo.
echo ==========================================
echo Project structure created successfully!
echo ==========================================
pause
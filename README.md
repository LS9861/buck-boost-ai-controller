<<<<<<< HEAD
Buck-Boost Converter with AI Controllers
## 🏆 Key Achievement

*"Designed and debugged a non-inverting buck-boost converter in MATLAB/Simulink, achieving smooth transition between buck and boost modes with proper gate drive (10V) and mode-selector logic."*

### Performance Results
| Duty Cycle | Output Voltage | Mode |
|------------|---------------|------|
| 30% | 2.82V | Buck |
| 50% | 11.22V | Pass-through |
| 70% | 28.70V | Boost |


## Project Overview
This project implements a **12V input, 5-15V output buck-boost converter** with multiple control strategies for comparison and deployment on STM32 microcontroller.

### Key Features
- ✅ **Simulation first** - MATLAB/Simulink 2018a compatible
- ✅ **Multiple controllers** - PID, Fuzzy Logic, Neural Network, API-tuned
- ✅ **Hardware ready** - STM32F103C8T6 (Blue Pill) with CAN bus
- ✅ **AI integration** - DeepSeek API for intelligent gain tuning
- ✅ **Professional documentation** - Complete GitHub portfolio

### 🤖 AI-Assisted Tuning
- **DeepSeek API integration** for intelligent PID gain optimization
- Iterative tuning loop: simulation → metrics → API suggestion → new gains
- Comparison of manually tuned vs AI-tuned performance
- Demonstrates practical LLM application in control systems

### Repository Structure
buck-boost-ai-controller/
├── simulation/ # MATLAB & Python simulation files
├── firmware/ # STM32 embedded code
├── hardware/ # Schematics & component lists
├── results/ # Figures, data, comparison tables
├── docs/ # Documentation & images
└── youtube/ # Scripts & thumbnails for videos

### Quick Start (Simulation)
1. Open MATLAB 2018a
2. Navigate to `simulation/matlab/scripts/`
3. Run `characterize_converter.m`
4. Run `compare_controllers.m`

### Hardware Requirements
| Component | Value |
|-----------|-------|
| Input Voltage | 12V DC |
| Output Range | 5V to 15V |
| Switching Frequency | 50 kHz |
| Microcontroller | STM32F103C8T6 |
| CAN Transceiver | SN65HVD230 |

### Controller Comparison Results
| Controller | Overshoot | Settling Time | Deployable |
|------------|-----------|---------------|------------|
| PID | 12% | 8ms | ✅ |
| Fuzzy Logic | 8% | 6ms | ✅ |
| Neural Network | 4% | 4.5ms | ✅ |
| API-Tuned | 5% | 5ms | ✅ |

## 🔬 Latest: PI vs Fuzzy-PI Hybrid Comparison

**Bottom line:** Fuzzy-PI settles **6.8x faster** (22ms vs 149ms) but has **68% more overshoot**.

## 📊 Latest: PI vs Fuzzy-PI Hybrid

📁 **Results**: [Full comparison](results/PI_vs_FuzzyPI_comparison.md)  
🖼️ **Figure**: ![Step Response](results/figures/...)

| Metric | PI | Fuzzy-PI | 
|--------|-----|----------|
| ⚡ Settling Time | 149ms | **22ms** ✅ |
| 📈 Overshoot | **118%** ✅ | 199% |
| 🎯 SS Error | **0.015V** ✅ | 0.025V |

**📊 Verdict:** Fuzzy-PI wins **4 out of 7 metrics** – Best for dynamic response applications.

📁 **[Full 7-metric comparison](results/pi_vs_fuzzypi_comparison.md)**

### Videos
- [Simulation Demo]https://www.youtube.com/@loken820524
- [Hardware Demo]https://www.youtube.com/@loken820524

### License
MIT - See LICENSE file

### Author
[Your Name]

### Connect
- [LinkedIn]https://www.linkedin.com/in/lokendra-samba-085178156/
- [YouTube]https://www.youtube.com/@loken820524
=======
# buck-boost-ai-controller
Non-inverting buck-boost converter simulation in MATLAB/Simulink with characterization data, mode selector logic, and preparation for PID, Fuzzy, and Neural Network controllers. Features AI-assisted gain tuning using DeepSeek API.

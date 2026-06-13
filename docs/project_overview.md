# Project Overview

## Objective
Design, simulate, and implement a buck-boost converter with multiple control strategies, demonstrating skills in:
- Power electronics design
- Control systems (PID, Fuzzy, Neural)
- Embedded systems (STM32, CAN bus)
- AI integration (LLM-assisted tuning)

## Technical Specifications

### Electrical
| Parameter | Value |
|-----------|-------|
| Input Voltage | 12V DC (fixed) |
| Output Voltage | 5V - 15V (variable) |
| Max Output Current | 500mA |
| Switching Frequency | 50 kHz |
| Topology | Non-inverting buck-boost |

### Components
| Component | Value |
|-----------|-------|
| Inductor | 47 µH, 1A |
| Input Capacitor | 100 µF + 0.1 µF |
| Output Capacitor | 47 µF + 0.1 µF |
| MOSFET | IRLZ44N (logic level) |
| Diode | 1N5819 (Schottky) |

### Control Strategies
1. **PID** - Baseline performance
2. **Fuzzy Logic** - Rule-based nonlinear control
3. **Neural Network** - Trained to mimic optimal control
4. **API-Tuned** - Gains optimized via DeepSeek LLM

## Milestones

| Phase | Status | Deliverable |
|-------|--------|-------------|
| Simulation | 🔄 In Progress | MATLAB model + characterization |
| PID Tuning | ⏳ Pending | Gains + step response |
| Fuzzy Logic | ⏳ Pending | Rule base + comparison |
| Neural Network | ⏳ Pending | Trained model + C code |
| Hardware | ⏳ Pending | STM32 + CAN implementation |
| Documentation | ⏳ Pending | YouTube video + GitHub |

## Success Criteria
- [ ] Simulation matches theoretical buck-boost behavior
- [ ] PID achieves <10% overshoot
- [ ] Neural network runs on STM32
- [ ] CAN communication working
- [ ] Complete YouTube tutorial published
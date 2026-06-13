# STM32 Firmware for Buck-Boost Converter

## Pin Mapping

| Function | STM32 Pin | Description |
|----------|-----------|-------------|
| PWM Output | PA8 (TIM1_CH1) | MOSFET gate drive (50kHz) |
| Voltage Sense | PA0 (ADC1) | Output voltage via 10k/1k divider |
| Current Sense | PA1 (ADC1) | Inductor current via ACS712 |
| CAN TX | PA12 | To SN65HVD230 TX pin |
| CAN RX | PA11 | To SN65HVD230 RX pin |
| LED Status | PB5 | Heartbeat / error indicator |
| Button | PB0 | User input for mode select |

## Build Instructions

### Prerequisites
- STM32CubeIDE (free from st.com)
- ST-LINK/V2 programmer
- USB to TTL (for debug output)

### Steps
1. Open STM32CubeIDE
2. File → Import → Existing Project
3. Select this folder
4. Build (Ctrl+B)
5. Flash (F8)

## CAN Message Protocol

### ID 0x100 - Telemetry (8 bytes)
| Byte | Content | Scaling |
|------|---------|---------|
| 0-1 | Vout | 0.01V per bit |
| 2-3 | Iout | 0.01A per bit |
| 4-5 | Duty cycle | 0.1% per bit |
| 6 | Status flags | Bitfield |
| 7 | Reserved | 0 |

### ID 0x101 - PID Gains Update (8 bytes)
| Byte | Content |
|------|---------|
| 0-1 | Kp (fixed-point Q16) |
| 2-3 | Ki (fixed-point Q16) |
| 4-5 | Kd (fixed-point Q16) |
| 6 | Checksum |
| 7 | Command ID |
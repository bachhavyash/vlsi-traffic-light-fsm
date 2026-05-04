# Traffic Light Controller (FSM) — Verilog HDL

## Overview
A **Moore Finite State Machine (FSM)** implementing a 2-road traffic light controller. The FSM cycles through 4 states managing safe signal transitions between Road A and Road B.

## State Diagram
```
        ┌─────────────────────────────────────┐
        ▼                                     │
[S0: A=GREEN,  B=RED]                         │
        │                                     │
        ▼                                     │
[S1: A=YELLOW, B=RED]                         │
        │                                     │
        ▼                                     │
[S2: A=RED,    B=GREEN]                       │
        │                                     │
        ▼                                     │
[S3: A=RED,    B=YELLOW] ──────────────────────┘
```

## Output Encoding — road = {RED, YELLOW, GREEN}
| Bits | Meaning |
|------|---------|
| 001  | GREEN   |
| 010  | YELLOW  |
| 100  | RED     |

## State Table
| State | Road A | Road B |
|-------|--------|--------|
| S0    | GREEN  | RED    |
| S1    | YELLOW | RED    |
| S2    | RED    | GREEN  |
| S3    | RED    | YELLOW |

## Files
| File | Description |
|------|-------------|
| `traffic_light.v` | FSM Design (Moore) |
| `traffic_light_tb.v` | Testbench — 20 clock cycles |

## Simulation Output (Expected)
```
====================================================
 Traffic Light FSM — Yashganesh Bachhav
====================================================
 Cycle | Road A  | Road B  | State
-------|---------|---------|------
    0  | GREEN   | RED     | A_GREEN
    1  | YELLOW  | RED     | A_YELLOW
    2  | RED     | GREEN   | B_GREEN
    3  | RED     | YELLW   | B_YELLOW
    4  | GREEN   | RED     | A_GREEN
   ...  (repeats)
```

## How to Run

### EDA Playground
1. [https://www.edaplayground.com](https://www.edaplayground.com)
2. Simulator: **Icarus Verilog 0.9.7**
3. Paste `traffic_light.v` → Design | `traffic_light_tb.v` → Testbench
4. Click **Run**

## Author
**Yashganesh Bachhav** | TE EnTC | LGNSCOE Nashik  
VLSI Internship — CODTECH IT Solutions (Jan–Feb 2025)

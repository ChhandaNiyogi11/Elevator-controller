# Elevator Control System - 4 Floors

This repository contains the Verilog implementation of a 4-floor elevator control system and its associated testbench. The design simulates the behavior of an elevator responding to floor requests, prioritizing movements, and handling resets.

## Features
- **Supports 4 floors**: Floor 0 (ground floor) to Floor 3.
- **One-hot request input**: Input requests for specific floors.
- **State management**: Maintains the current floor and movement state.
- **Priority handling**: Processes multiple simultaneous requests with priority.
- **Reset functionality**: Resets the elevator to the ground floor.

## Files in the Repository
- **`Elevator_controller_design.v`**: Verilog module implementing the elevator control system.
- **`testbench.v`**: Testbench module for simulating and verifying the elevator control system.

## Elevator Control Module (`Elevator_controller_design.v`)
### Ports
- **Inputs**:
  - `clk`: Clock signal.
  - `reset`: Reset signal. Resets the elevator to the ground floor.
  - `request[3:0]`: One-hot encoded requests for floors 0-3.
- **Outputs**:
  - `current_floor[1:0]`: Indicates the current floor of the elevator.
  - `moving`: Indicates whether the elevator is currently moving.

### Functionality
- Initializes to **Floor 0** upon reset.
- Processes requests based on priority:
  - Highest priority: Floor 3.
  - Lowest priority: Floor 0.
- Elevator moves only when there is a valid request to a different floor.
- Handles simultaneous requests by servicing the highest-priority floor first.

## Testbench (`testbench.v`)
The testbench simulates various scenarios to verify the functionality of the elevator control system.

### Test Cases
1. **Move to Floor 2**: Single floor request.
2. **Move to Floor 3**: Request for the top floor.
3. **Move to Floor 0**: Returning to the ground floor from Floor 3.
4. **Multiple simultaneous requests**: Request for Floors 1 and 3 at the same time.
5. **Reset during movement**: Simulates reset while the elevator is in transit.

### Simulation Details
- A **100MHz clock** (`clk`) is generated with a 10ns period.
- Outputs are monitored to ensure correctness:
  - `current_floor`: Tracks the elevator's current location.
  - `moving`: Indicates movement between floors.



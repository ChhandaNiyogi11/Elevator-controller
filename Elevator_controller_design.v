module elevator_controller(
    input clk,            // Clock signal
    input reset,          // Reset signal
    input [1:0] request, // Elevator requests (2-bit input for 3 floors: 00 -> no request, 01 -> request at floor 1, 10 -> request at floor 2)
    output reg [1:0] floor, // Current floor (2-bit output for 3 floors)
    output reg moving     // Moving status (1: Moving, 0: Idle)
);

    // State Definitions
    parameter FLOOR_0 = 2'b00;
    parameter FLOOR_1 = 2'b01;
    parameter FLOOR_2 = 2'b10;

    reg [1:0] state, next_state;

    // State transitions
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= FLOOR_0; // Reset to floor 0
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case(state)
            FLOOR_0: begin
                if (request == 2'b01) next_state = FLOOR_1; // Request at floor 1
                else if (request == 2'b10) next_state = FLOOR_2; // Request at floor 2
                else next_state = FLOOR_0;
            end
            FLOOR_1: begin
                if (request == 2'b10) next_state = FLOOR_2; // Request at floor 2
                else if (request == 2'b00) next_state = FLOOR_0; // No more request
                else next_state = FLOOR_1;
            end
            FLOOR_2: begin
                if (request == 2'b01) next_state = FLOOR_1; // Request at floor 1
                else if (request == 2'b00) next_state = FLOOR_0; // No more request
                else next_state = FLOOR_2;
            end
            default: next_state = FLOOR_0;
        endcase
    end

    // Output logic (moving and floor signal)
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            floor <= FLOOR_0; // Reset to floor 0
            moving <= 0;
        end else begin
            floor <= state;
            moving <= (state != next_state); // Moving when the state changes
        end
    end

endmodule

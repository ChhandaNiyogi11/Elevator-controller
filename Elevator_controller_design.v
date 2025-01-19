`timescale 1ns / 1ps

module elevator_control_4floors (
    input clk,                  // Clock signal
    input reset,                // Reset signal
    input [3:0] request,        // Input requests for floors (one-hot: floor 0, 1, 2, or 3)
    output reg [1:0] current_floor, // Current floor indicator
    output reg moving           // Indicates if the elevator is moving
);

    // Parameters for floors
    parameter FLOOR_0 = 2'b00;
    parameter FLOOR_1 = 2'b01;
    parameter FLOOR_2 = 2'b10;
    parameter FLOOR_3 = 2'b11;

    // State machine for the elevator
    reg [1:0] next_floor;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_floor <= FLOOR_0; // Reset to ground floor
            moving <= 0;
        end else begin
            current_floor <= next_floor;
            moving <= (next_floor != current_floor); // Moving if next floor differs
        end
    end

    always @(*) begin
        // Default: no movement
        next_floor = current_floor;

        // Priority management: descending order of floors
        case (current_floor)
            FLOOR_0: begin
                if (request[3]) next_floor = FLOOR_3;
                else if (request[2]) next_floor = FLOOR_2;
                else if (request[1]) next_floor = FLOOR_1;
            end
            FLOOR_1: begin
                if (request[3]) next_floor = FLOOR_3;
                else if (request[2]) next_floor = FLOOR_2;
                else if (request[0]) next_floor = FLOOR_0;
            end
            FLOOR_2: begin
                if (request[3]) next_floor = FLOOR_3;
                else if (request[1]) next_floor = FLOOR_1;
                else if (request[0]) next_floor = FLOOR_0;
            end
            FLOOR_3: begin
                if (request[2]) next_floor = FLOOR_2;
                else if (request[1]) next_floor = FLOOR_1;
                else if (request[0]) next_floor = FLOOR_0;
            end
        endcase
    end
endmodule

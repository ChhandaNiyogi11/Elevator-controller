`timescale 1ns / 1ps

module tb_elevator_control_4floors;

    // Inputs to the elevator control module
    reg clk;
    reg reset;
    reg [3:0] request;

    // Outputs from the elevator control module
    wire [1:0] current_floor;
    wire moving;

    // Instantiate the elevator control module
    elevator_control_4floors uut (
        .clk(clk),
        .reset(reset),
        .request(request),
        .current_floor(current_floor),
        .moving(moving)
    );

    // Clock generation (10ns period: 100MHz clock)
    always #5 clk = ~clk;

    // Test sequence
    initial begin
        // Initialize signals
        clk = 0;
        reset = 1;
        request = 4'b0000;

        // Reset the elevator
        #10;
        reset = 0;

        // Test case 1: Request to move to Floor 2
        #10;
        request = 4'b0100; // Request Floor 2
        #50;
        request = 4'b0000; // Clear requests

        // Test case 2: Request to move to Floor 3
        #10;
        request = 4'b1000; // Request Floor 3
        #50;
        request = 4'b0000; // Clear requests

        // Test case 3: Request to move to Floor 0 from Floor 3
        #10;
        request = 4'b0001; // Request Floor 0
        #50;
        request = 4'b0000; // Clear requests

        // Test case 4: Multiple simultaneous requests
        #10;
        request = 4'b1010; // Request Floors 1 and 3
        #50;
        request = 4'b0000; // Clear requests

        // Test case 5: Reset while the elevator is moving
        #10;
        request = 4'b0010; // Request Floor 1
        #20;
        reset = 1;         // Reset during movement
        #10;
        reset = 0;         // Release reset
        request = 4'b0000; // Clear requests

        // End simulation-
        #50;
        $stop;
    end
endmodule


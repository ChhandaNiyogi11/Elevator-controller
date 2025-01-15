module elevator_tb;
    reg clk;
    reg reset;
    reg [1:0] request;
    wire [1:0] floor;
    wire moving;

    // Instantiate the elevator controller
    elevator_controller uut (
        .clk(clk),
        .reset(reset),
        .request(request),
        .floor(floor),
        .moving(moving)
    );

    // Clock generation
    always #5 clk = ~clk; // 10 ns clock period

    // Test procedure
    initial begin
        // Initialize signals
        clk = 0;
        reset = 1;
        request = 2'b00; // No request

        // Reset the elevator
        #10 reset = 0;

        // Test case 1: Request at floor 1
        #10 request = 2'b01; // Request at floor 1
         

        // Test case 2: Request at floor 2
        #20 request = 2'b10; // Request at floor 2
        

        // Test case 3: Request at floor 1 while on floor 2
        #20 request = 2'b01; // Request at floor 1
        

        // End of test
        #20 $finish;
    end

    // Monitor output signals
    initial begin
        $monitor("Time: %0t, Reset: %b, Request: %b, Floor: %b, Moving: %b", 
                 $time, reset, request, floor, moving);
    end

endmodule

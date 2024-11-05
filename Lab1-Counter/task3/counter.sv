module counter #(
    parameter WIDTH = 8
)(

    input logic              clk,  // Clock
    input logic              rst,  //reset
    input logic             ld, 
    input logic [WIDTH-1:0]  v, //value to preload
    output logic [WIDTH-1:0] count //count output
);

logic ld_last;

always_ff @ (posedge clk) 
    if (rst) begin
        count <= {WIDTH{1'b0}};
        ld_last <= 0;

    end else begin
        // Detect rising edge of ld
        if (ld && !ld_last)
            count <= count + {{WIDTH-1{1'b0}}, 1'b1}; // Increment on ld rising edge

        ld_last <= ld;
     end

endmodule

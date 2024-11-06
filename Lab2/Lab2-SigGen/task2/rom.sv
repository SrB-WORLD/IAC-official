module rom #(
    parameter ADDRESS_WIDTH = 8,
              DATA_WIDTH = 8
)(
    input logic                clk,
    input logic [ADDRESS_WIDTH-1:0] addr1,  // First address port
    input logic [ADDRESS_WIDTH-1:0] addr2,  // Second address port (offset address)
    output logic [DATA_WIDTH-1:0] dout1,    // Output for first port
    output logic [DATA_WIDTH-1:0] dout2     // Output for second port
);

    logic [DATA_WIDTH-1:0] rom_array [2**ADDRESS_WIDTH-1:0];

    initial begin
        $display("Loading ROM.");
        readmemh("sinrom.mem", rom_array);  // Load sinewave data
    end

    always_ff @(posedge clk) begin
        dout1 <= rom_array[addr1];  // Output from first port
        dout2 <= rom_array[addr2];  // Output from second port (offset)
    end

endmodule

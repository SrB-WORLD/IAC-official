module sinegen #(
    parameter A_WIDTH = 8,
              D_WIDTH = 8
)(
    input logic                 clk,
    input logic                 rst,
    input logic                 en,
    input logic [D_WIDTH-1:0]   incr,  // Frequency increment
    input logic [7:0]           phase_offset,  // Phase offset from Vbuddy
    output logic [D_WIDTH-1:0]  dout1,  // First output sinewave
    output logic [D_WIDTH-1:0]  dout2   // Second output sinewave (offset phase)
);

    logic [A_WIDTH-1:0]         addr1;
    logic [A_WIDTH-1:0]         addr2;

    // Counter for address generation
    counter addrCounter (
        .clk (clk),
        .rst (rst),
        .en (en),
        .incr (incr),
        .count (addr1)  // Generate address for first ROM port
    );

    // Second address is the first address with phase offset
    assign addr2 = addr1 + phase_offset;

    // Dual-port ROM with two addresses
    rom sineRom (
        .clk (clk),
        .addr1 (addr1),  // Address for first port
        .addr2 (addr2),  // Address for second port
        .dout1 (dout1),  // Output for first port
        .dout2 (dout2)   // Output for second port
    );

endmodule

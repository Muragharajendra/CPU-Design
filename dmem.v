module dmem(
    input clk, we,
    input [31:0] a, wd,
    output reg [31:0] rd
);

    reg [31:0] RAM[63:0]; // 64 words of 32-bit memory

    // Read logic (combinational)
    always @(*) begin
        rd = RAM[a[31:2]]; // word-aligned read
    end

    // Write logic (synchronous)
    always @(posedge clk) begin
        if (we)
            RAM[a[31:2]] <= wd;
    end
endmodule

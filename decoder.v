module decoder(
    input [1:0] Op,
    input [5:0] Funct,
    input [3:0] Rd,
    output reg [1:0] FlagW,
    output reg PCS,
    output reg RegW, MemW,
    output reg MemtoReg, ALUSrc,
    output reg [1:0] ImmSrc, RegSrc,
    output reg [1:0] ALUControl
);

// internal control signals
reg Branch, ALUOp;
reg [9:0] controls;

// main decoder logic
always @(*) begin
    casex (Op)
        2'b00: begin
            if (Funct[5])
                controls = 10'b0001001001; // Data-processing immediate
            else
                controls = 10'b0000001001; // Data-processing register
        end

        2'b01: begin
            if (Funct[0])
                controls = 10'b0101011000; // LDR
            else
                controls = 10'b0011010100; // STR
        end

        2'b10: controls = 10'b1001100010; // Branch

        default: controls = 10'bxxxxxxxxxx; // Unimplemented
    endcase

    // Extract individual signals
    Branch    = controls[9];
    MemtoReg  = controls[8];
    MemW      = controls[7];
    ALUSrc    = controls[6];
    ImmSrc    = controls[5:4];
    RegW      = controls[3];
    RegSrc    = controls[2:1];
    ALUOp     = controls[0];
end

// ALU decoder and flag write control
always @(*) begin
    if (ALUOp) begin
        case (Funct[4:1])
            4'b0100: ALUControl = 2'b00; // ADD
            4'b0010: ALUControl = 2'b01; // SUB
            4'b0000: ALUControl = 2'b10; // AND
            4'b1100: ALUControl = 2'b11; // ORR
            default: ALUControl = 2'bxx; // Unimplemented
        endcase

        // Update flags if S bit is set
        FlagW[1] = Funct[0]; // Z flag
        FlagW[0] = Funct[0] & (ALUControl == 2'b00 || ALUControl == 2'b01); // N/V
    end else begin
        ALUControl = 2'b00; // default ADD
        FlagW = 2'b00;      // don't update flags
    end
end

// Program counter select logic
always @(*) begin
    PCS = ((Rd == 4'b1111) & RegW) | Branch;
end

endmodule

module controller(
  input clk, reset,
  input  [31:12] Instr,
  input  [3:0] ALUFlags,
  output reg [1:0] RegSrc,
  output reg RegWrite,
  output reg [1:0] ImmSrc,
  output reg ALUSrc,
  output reg [1:0] ALUControl,
  output reg MemWrite, MemtoReg,
  output reg PCSrc
);

  // Internal wires for decoder and condlogic outputs
  wire [1:0] w_RegSrc;
  wire [1:0] w_ImmSrc;
  wire w_ALUSrc;
  wire [1:0] w_ALUControl;
  wire w_MemtoReg;
  wire [1:0] FlagW;
  wire PCS, RegW, MemW;

  // Wires for condlogic outputs
  wire w_PCSrc, w_RegWrite, w_MemWrite;

  // Instantiate decoder
  decoder dec(
    Instr[27:26], Instr[25:20], Instr[15:12],
    FlagW, PCS, RegW, MemW,
    w_MemtoReg, w_ALUSrc, w_ImmSrc, w_RegSrc, w_ALUControl
  );

  // Assign decoder outputs to reg outputs
  always @(*) begin
    RegSrc     = w_RegSrc;
    ImmSrc     = w_ImmSrc;
    ALUSrc     = w_ALUSrc;
    ALUControl = w_ALUControl;
    MemtoReg   = w_MemtoReg;
  end

  // Instantiate condlogic
  condlogic cl(
    clk, reset, Instr[31:28], ALUFlags,
    FlagW, PCS, RegW, MemW,
    w_PCSrc, w_RegWrite, w_MemWrite
  );

  // Assign condlogic outputs to reg outputs
  always @(*) begin
    PCSrc   = w_PCSrc;
    RegWrite = w_RegWrite;
    MemWrite = w_MemWrite;
  end

endmodule

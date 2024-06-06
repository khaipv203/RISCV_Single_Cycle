module Imm_Gen (
    input [31:0] inst,
    output reg [31:0] imm
);
    localparam R_Arith = 7'b0110011;
    localparam I_Arith = 7'b0010011;
    localparam I_Load = 7'b0000011;
    localparam S_Type = 7'b0100011;
    localparam B_Type = 7'b1100011;
    localparam JALR = 7'b1100111;
    localparam JAL = 7'b1101111;
    localparam LUI = 7'b0110111;
    localparam AUIPC = 7'b0010111;

    wire [6:0] opcode;
    assign opcode = inst[6:0];

    always @(inst) begin
        case (opcode)
            I_Arith, I_Load, JALR: imm = {{20{inst[31]}}, inst[31:20]};
            S_Type: imm = {{20{inst[31]}}, inst[31:25], inst[11:7]}; 
            B_Type: imm = {{20{inst[31]}}, inst[7], inst[30:25], inst[11:8], 1'b0};
            JAL: imm = {{12{inst[31]}}, inst[19:12], inst[20], inst[30:21], 1'b0};
            LUI, AUIPC: imm = {{inst[31:12]}, 12'b0};
            default: imm = 0;
        endcase
    end
endmodule
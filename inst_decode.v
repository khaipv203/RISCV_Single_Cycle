module inst_decode(
    input [31:0] inst,
    output [4:0] rs1, rs2, rd,
    output [6:0] opcode,
    output [2:0] func3,
    output [6:0] func7
    //output [31:0] imm
);
    assign opcode = inst[6:0];
    assign rd = inst[11:7];
    assign func3 = inst[14:12];
    assign rs1 = inst[19:15];
    assign rs2 = inst[24:20];
    assign func7 = inst[31:25];

    
endmodule

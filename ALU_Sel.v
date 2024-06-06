module ALU_Sel (
    input [31:0] imm, pc, DataA, DataB,
    // input ASel, BSel,
    input [1:0] ASel, BSel,
    output [31:0] op1, op2
);
    localparam other_sel = 2'b01;
    localparam data_sel = 2'b10;
    localparam no_sel = 2'b00;
    assign op2 = (BSel == other_sel) ? imm :
                 (BSel == data_sel) ? DataB : 32'b0;
    assign op1 = (ASel == other_sel) ? pc :
                 (ASel == data_sel) ? DataA : 32'b0;
endmodule
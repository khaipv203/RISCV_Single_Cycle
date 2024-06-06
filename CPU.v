`timescale 1ps/1ps
module CPU(
	input clk, rst_n
);  
    
    wire [31:0] inst;
    wire [31:0] pc;
    wire [31:0] pc_added;
    wire pc_sel;
    wire [31:0] imm;
    wire [3:0] ALUop;
    wire regWEn;
    wire [1:0] ASel; 
    wire [1:0] BSel; 
    wire BrEq;
    wire BrLT;
    wire BrUn;
    wire [1:0] memRW;
    wire [4:0] rs1;
    wire [4:0] rs2; 
    wire [4:0] rd;
    wire [6:0] opcode;
    wire [2:0] func3;
    wire [6:0] func7;
    wire [31:0] op1, op2;
    wire [31:0] ALU_out; 
    wire [31:0] DataA; 
    wire [31:0] DataB;
    wire [31:0] data_out;
    wire [31:0] WB_Data;
    wire [1:0] WBsel;
    /////////////////////////////////////////////////////////////////
    PC pc_block
    (
        //input
        .clk(clk), 
        .rst_n(rst_n), 
        .pc_sel(pc_sel),
        .pc_wb(ALU_out),
        .pc_added(pc_added),

        //output
        .pc(pc)
    );

    pc_adder PA
    (
        //input
        .pc(pc),
        
        //output
        .pc_added(pc_added)
    );

    inst_mem IMEM
    (
        //input
        .rst_n(rst_n), 
        .pc(pc), 

        //output
        .inst(inst)
    );
//////////////////////////////////////////////////////////////////////////////////////////

    Imm_Gen IMG
    (
        //input
        .inst(inst), 
        
        //output
        .imm(imm)
    );


    inst_decode ID
    (
        //input
        .inst(inst), 
        .rs1(rs1), 
        .rs2(rs2), 
        .rd(rd), 

        //output
        .opcode(opcode), 
        .func3(func3), 
        .func7(func7)
    );


    reg_file reg_block
    (   
        //input
        .clk(clk), 
        .rst_n(rst_n), 
        .regWEn(regWEn), 
        .DataD(WB_Data), 
        .rs1(rs1), 
        .rs2(rs2), 
        .rd(rd), 

        //output
        .DataA(DataA), 
        .DataB(DataB)
    );
//////////////////////////////////////////////////////////////////////////////////////////


    branch_comparator BC
    (
        //input
        .DataA(DataA),
        .DataB(DataB), 
        .BrUn(BrUn),

        //output
        .BrEq(BrEq),
        .BrLT(BrLT)
    );

    ALU_Sel AS
    (
        //input
        .imm(imm), 
        .pc(pc),
        .DataA(DataA), 
        .DataB(DataB),
        .ASel(ASel), 
        .BSel(BSel), 

        //output
        .op1(op1), 
        .op2(op2)
    );

    
    ALU alu_block
    (
        //input
        .ALUop(ALUop), 
        .op1(op1), 
        .op2(op2), 

        //output
        .ALU_out(ALU_out)
    );

/////////////////////////////////////////////////////////////////////////////////////////

    data_mem DM
    (
        //input
        .clk(clk), 
        .rst_n(rst_n), 
        .memRW(memRW), 
        .addr(ALU_out), 
        .data_in(DataB), 

        //output
        .data_out(data_out)
    );


///////////////////////////////////////////////////////////////////////////
    wb_sel WB
    (
        //input
        .WBsel(WBsel), 
        .ALU_out(ALU_out), 
        .data_out(data_out),
        .pc_added(pc_added),

        //output 
        .WB_Data(WB_Data)
    );

///////////////////////////////////////////////////////////////////////////
    control_block ctrl_unit
    (
        //input
        .opcode(opcode), 
        .func3(func3), 
        .func7(func7), 
        .BrEq(BrEq),
        .BrLT(BrLT),

        //output
        .pc_sel(pc_sel),
        .ALUop(ALUop), 
        .regWEn(regWEn), 
        .ASel(ASel),
        .BSel(BSel), 
        .memRW(memRW), 
        .WBsel(WBsel),
        .BrUn(BrUn)
    );
endmodule
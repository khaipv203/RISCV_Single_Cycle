module control_block (
    input [6:0] opcode, func7,
    input [2:0] func3,
    input BrLT, BrEq,
    output reg pc_sel,
    output reg [3:0] ALUop,
    output reg regWEn,
    output reg BrUn,
    output reg [1:0] ASel,
    output reg [1:0] BSel,
    output reg [1:0] memRW,
    output reg [1:0] WBsel
    
);  

    //pc_sel param
    localparam pc_wb_sel = 1'b1;
    localparam pc_next_sel = 1'b0;

    //opcode parameter
    localparam R_Arith = 7'b0110011;
    localparam I_Arith = 7'b0010011;
    localparam I_Load = 7'b0000011;
    localparam S_Type = 7'b0100011;
    localparam B_Type = 7'b1100011;
    localparam JALR = 7'b1100111;
    localparam JAL = 7'b1101111;
    localparam LUI = 7'b0110111;
    localparam AUIPC = 7'b0010111;


    //func7_param
    localparam func7_sub_SRA = 7'b0100000;
    localparam func7_nor = 7'b0000000;

    //Arithmetic func3 param
    localparam func3_ADD = 3'b000;
    localparam func3_XOR = 3'b100;
    localparam func3_OR = 3'b110;
    localparam func3_AND = 3'b111;
    localparam func3_SLL = 3'b001;
    localparam func3_SR = 3'b101;
    localparam func3_SLT = 3'b010;

    //ALU_sel param
    localparam other_sel = 2'b01;
    localparam data_sel = 2'b10;
    localparam no_sel = 2'b00;

    //ALUop parameter
    localparam ADD_op = 4'b0000;
    localparam SUB_op = 4'b0001;
    localparam AND_op = 4'b0010;
    localparam OR_op = 4'b0011;
    localparam XOR_op = 4'b0100;
    localparam SLL_op = 4'b0101; //Shift Left Logical
    localparam SRL_op = 4'b0110; //Shift Right Logical 
    localparam SRA_op = 4'b0111; //Shift Right Arith

    //Branch comparator param = {BrEq,BrLt, func3}
    localparam beq = 5'b10000;
    localparam blt = 5'b01100;
    localparam bge = 5'b00101;
    localparam bne_1 = 5'b01001;
    localparam bne_2 = 5'b00001;
    localparam branch_Unsigned = 1'b0;
    localparam branch_Signed = 1'b1;

    // //Branch Func3 Param
    // localparam beq = 3'b000;
    // localparam bne = 3'b001;
    // localparam blt = 3'b100;
    // localparam bge = 3'b101;

    //Reg_file enable param
    localparam enable_write = 1'b1;
    localparam disable_write = 1'b0;

    //memRW param
    localparam read_mem = 2'b01;
    localparam write_mem = 2'b10;
    localparam no_access = 2'b00;

    //WB param
    localparam data_mem_sel = 2'b00;
    localparam alu_out_sel = 2'b01;
    localparam pc_addr_sel = 2'b10;
    localparam no_WB = 2'b11;

    
////////////////////////////////////////////////////////////////////////////////

    always @(opcode or func7 or func3) begin
        case (opcode)
            R_Arith: begin
                pc_sel <= pc_next_sel;
                regWEn <= enable_write;
                ASel <= data_sel;
                BSel <= data_sel;
                WBsel <= alu_out_sel;
                memRW <= no_access;
                BrUn <= branch_Signed;
                if(func7 == func7_nor) begin
                    case (func3)
                        func3_ADD: ALUop <= ADD_op;
                        func3_XOR: ALUop <= XOR_op;
                        func3_AND: ALUop <= AND_op;
                        func3_SLL: ALUop <= SLL_op;
                        func3_SR: ALUop <= SRL_op;
                        default: ALUop <= 4'b1111;
                    endcase
                end
                else begin
                    case (func3)
                        func3_ADD: ALUop <= SUB_op;  
                        func3_SR: ALUop <= SRA_op;
                        default: ALUop <= 4'b1111;
                    endcase
                end
            end
            I_Arith: begin
                pc_sel <= pc_next_sel;
                regWEn <= enable_write;
                ASel <= data_sel;
                BSel <= other_sel;
                WBsel <= alu_out_sel;
                memRW <= no_access;
                BrUn <= branch_Signed;
                case (func3)
                    func3_ADD: ALUop <= ADD_op;
                    func3_XOR: ALUop <= XOR_op;
                    func3_AND: ALUop <= AND_op;
                    func3_SLL: ALUop <= SLL_op;
                    func3_SR: begin
                        if(func7 == func7_sub_SRA) ALUop <= SRA_op;
                        else ALUop <= SRL_op;
                    end 
                    default: ALUop <= 4'b1111;
                endcase
            end  
            I_Load: begin
                pc_sel <= pc_next_sel;
                regWEn <= enable_write;
                ASel <= data_sel;
                BSel <= other_sel;
                memRW <= read_mem;
                WBsel <= data_mem_sel;
                ALUop <= ADD_op;
                BrUn <= branch_Signed;
            end  
            S_Type: begin
                pc_sel <= pc_next_sel;
                WBsel <= no_WB;
                ALUop <= ADD_op;
                regWEn <= disable_write;
                memRW <= write_mem;
                ASel <= data_sel;
                BSel <= other_sel;
                BrUn <= branch_Signed;
            end
            B_Type: begin
                regWEn <= disable_write;
                memRW <= no_access;
                ALUop <= ADD_op;
                ASel <= other_sel;
                BSel <= other_sel;
                WBsel <= no_WB;
                BrUn <= branch_Signed;
                case ({BrEq, BrLT, func3})
                    beq, blt, bge, bne_1, bne_2: begin
                        pc_sel <= pc_wb_sel;
                    end 
                    default: pc_sel <= pc_next_sel;
                endcase
            end
            JALR: begin
                regWEn <= enable_write;
                memRW <= no_access;
                ALUop <= ADD_op;
                ASel <= other_sel;
                BSel <= other_sel;
                WBsel <= pc_addr_sel;
                BrUn <= branch_Signed;
                pc_sel <= pc_wb_sel;
            end
            JAL: begin
                regWEn <= enable_write;
                memRW <= no_access;
                ALUop <= ADD_op;
                ASel <= other_sel;
                BSel <= other_sel;
                WBsel <= pc_addr_sel;
                BrUn <= branch_Signed;
                pc_sel <= pc_wb_sel;
            end
            LUI: begin
                regWEn <= enable_write;
                memRW <= no_access;
                ALUop <= ADD_op;
                ASel <= no_sel;
                BSel <= other_sel;
                WBsel <= alu_out_sel;
                BrUn <= branch_Signed;
                pc_sel <= pc_next_sel;
            end
            AUIPC: begin
                regWEn <= enable_write;
                memRW <= no_access;
                ALUop <= ADD_op;
                ASel <= other_sel;
                BSel <= other_sel;
                WBsel <= alu_out_sel;
                BrUn <= branch_Signed;
                pc_sel <= pc_next_sel;
            end
        endcase
    end
        

endmodule
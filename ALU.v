module ALU (
    input [3:0] ALUop, 
    input [31:0] op1, op2,
    output reg [31:0] ALU_out
);
    localparam ADD_op = 4'b0000;
    localparam SUB_op = 4'b0001;
    localparam AND_op = 4'b0010;
    localparam OR_op = 4'b0011;
    localparam XOR_op = 4'b0100;
    localparam SLL_op = 4'b0101; //Shift Left Logical
    localparam SRL_op = 4'b0110; //Shift Right Logical 
    localparam SRA_op = 4'b0111; //Shift Right Arith
    localparam SLT_op = 4'b1000; //Set less than


    reg [31:16]     shift_right_fill_r;
    reg [31:0]      shift_right_1_r;
    reg [31:0]      shift_right_2_r;
    reg [31:0]      shift_right_4_r;
    reg [31:0]      shift_right_8_r;
    reg [31:0]      shift_left_1_r;
    reg [31:0]      shift_left_2_r;
    reg [31:0]      shift_left_4_r;
    reg [31:0]      shift_left_8_r;

    always @(op1 or op2 or ALUop) begin

        shift_right_fill_r = 16'b0;
        shift_right_1_r = 32'b0;
        shift_right_2_r = 32'b0;
        shift_right_4_r = 32'b0;
        shift_right_8_r = 32'b0;
        shift_left_1_r = 32'b0;
        shift_left_2_r = 32'b0;
        shift_left_4_r = 32'b0;
        shift_left_8_r = 32'b0;


        case (ALUop)
            ADD_op: begin
                ALU_out <= (op1 + op2);
            end
            SUB_op: begin
                ALU_out <= (op1 - op2);
            end
            OR_op: begin
                ALU_out <= (op1 | op2);
            end
            AND_op: begin
                ALU_out <= (op1 & op2);
            end
            XOR_op: begin
                ALU_out <= (op1 ^ op2);
            end
            SLL_op: begin
                if (op2[0] == 1'b1)
                shift_left_1_r = {op1[30:0],1'b0};
                else
                    shift_left_1_r = op1;

                if (op2[1] == 1'b1)
                    shift_left_2_r = {shift_left_1_r[29:0],2'b00};
                else
                    shift_left_2_r = shift_left_1_r;

                if (op2[2] == 1'b1)
                    shift_left_4_r = {shift_left_2_r[27:0],4'b0000};
                else
                    shift_left_4_r = shift_left_2_r;

                if (op2[3] == 1'b1)
                    shift_left_8_r = {shift_left_4_r[23:0],8'b00000000};
                else
                    shift_left_8_r = shift_left_4_r;

                if (op2[4] == 1'b1)
                    ALU_out = {shift_left_8_r[15:0],16'b0000000000000000};
                else
                    ALU_out = shift_left_8_r;
            end
            SRL_op, SRA_op: begin
                if (op1[31] == 1'b1 && ALUop == SRA_op)
                    shift_right_fill_r = 16'b1111111111111111;
                else
                    shift_right_fill_r = 16'b0000000000000000;
    
                if (op2[0] == 1'b1)
                    shift_right_1_r = {shift_right_fill_r[31], op1[31:1]};
                else
                    shift_right_1_r = op1;
    
                if (op2[1] == 1'b1)
                    shift_right_2_r = {shift_right_fill_r[31:30], shift_right_1_r[31:2]};
                else
                    shift_right_2_r = shift_right_1_r;
    
                if (op2[2] == 1'b1)
                    shift_right_4_r = {shift_right_fill_r[31:28], shift_right_2_r[31:4]};
                else
                    shift_right_4_r = shift_right_2_r;
    
                if (op2[3] == 1'b1)
                    shift_right_8_r = {shift_right_fill_r[31:24], shift_right_4_r[31:8]};
                else
                    shift_right_8_r = shift_right_4_r;
    
                if (op2[4] == 1'b1)
                    ALU_out = {shift_right_fill_r[31:16], shift_right_8_r[31:16]};
                else
                    ALU_out = shift_right_8_r;
            end
            SLT_op: begin
                ALU_out = (op1 < op2) ? 32'b1 : 32'b0;
            end
            default: begin
                ALU_out <= 32'b0;
            end
        endcase
        // if(ALUop == AND_op) ALU_out <= op1 & op2;
        // else if(ALUop == OR_op) ALU_out <= op1 | op2;
        // else if(ALUop == ADD_op) ALU_out <= op1 + op2;
        // else if(ALUop == SUB_op) ALU_out <= op1 - op2;
        // else ALU_out <= ALU_out;
    end
endmodule
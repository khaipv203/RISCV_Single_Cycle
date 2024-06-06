module reg_file (
    input clk, rst_n,
    input [4:0] rs1, rs2, rd,
    input regWEn,
    input [31:0] DataD, //data in addr_rd
    output [31:0] DataA, DataB //data in addr_rs1 and addr_rs2

);
    reg [31:0] reg_file [31:0];
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            reg_file[0] <= 0;
            reg_file[1] <= 0;
            reg_file[2] <= 0;
            reg_file[3] <= 0;
            reg_file[4] <= 0;
            reg_file[5] <= 0;
            reg_file[6] <= 0;
            reg_file[7] <= 0;
            reg_file[8] <= 0;
            reg_file[9] <= 0;
            reg_file[10] <= 0;
            reg_file[11] <= 0;
            reg_file[12] <= 0;
            reg_file[13] <= 0;
            reg_file[14] <= 0;
            reg_file[15] <= 0;
            reg_file[16] <= 0;
            reg_file[17] <= 0;
            reg_file[18] <= 0;
            reg_file[19] <= 0;
            reg_file[20] <= 0;
            reg_file[21] <= 0;
            reg_file[22] <= 0;
            reg_file[23] <= 0;
            reg_file[24] <= 0;
            reg_file[25] <= 0;
            reg_file[26] <= 0;
            reg_file[27] <= 0;
            reg_file[28] <= 0;
            reg_file[29] <= 0;
            reg_file[30] <= 0;
            reg_file[31] <= 0;
        end
        else begin
            if(regWEn) begin
                reg_file[rd] <= DataD;
            end
            else begin
                reg_file[rd] <= reg_file[rd];
            end
            
        end
    end
    assign DataA = reg_file[rs1];
    assign DataB = reg_file[rs2];
endmodule
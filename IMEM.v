module inst_mem (
    input rst_n,
    input [31:0] pc,
    output [31:0] inst
);
    reg [7:0] mem_cell [39:0];
    always @(negedge rst_n) begin
        if(!rst_n) begin
            mem_cell[0] <= 8'h83;//lw x15, 8(x17)
            mem_cell[1] <= 8'ha7;
            mem_cell[2] <= 8'h88;
            mem_cell[3] <= 8'h00;
            mem_cell[4] <= 8'h93;//slli x15, x15, 1
            mem_cell[5] <= 8'h97;
            mem_cell[6] <= 8'h17;
            mem_cell[7] <= 8'h00;
            mem_cell[8] <= 8'he7;//jalr x1, 16(x16)
            mem_cell[9] <= 8'h00;
            mem_cell[10] <= 8'h08;
            mem_cell[11] <= 8'h01;
            mem_cell[12] <= 8'h13;
            mem_cell[13] <= 8'h00;
            mem_cell[14] <= 8'h00; 
            mem_cell[15] <= 8'h00;
            mem_cell[16] <= 8'h13;
            mem_cell[17] <= 8'h00;
            mem_cell[18] <= 8'h00;
            mem_cell[19] <= 8'h00;
            mem_cell[20] <= 8'h13;
            mem_cell[21] <= 8'h00;
            mem_cell[22] <= 8'h00;
            mem_cell[23] <= 8'h00;
            mem_cell[24] <= 8'hb3;//add x17, x15, x15
            mem_cell[25] <= 8'h88;
            mem_cell[26] <= 8'hf7;
            mem_cell[27] <= 8'h00;
            mem_cell[28] <= 8'h13;
            mem_cell[29] <= 8'h00;
            mem_cell[30] <= 8'h00;
            mem_cell[31] <= 8'h00;
            mem_cell[32] <= 8'h13;
            mem_cell[33] <= 8'h00;
            mem_cell[34] <= 8'h00; 
            mem_cell[35] <= 8'h00;
            mem_cell[36] <= 8'h13;
            mem_cell[37] <= 8'h00;
            mem_cell[38] <= 8'h00;
            mem_cell[39] <= 8'h00;
        end
        else begin
            mem_cell[0] <= mem_cell[0];
            mem_cell[1] <= mem_cell[1];
            mem_cell[2] <= mem_cell[2];
            mem_cell[3] <= mem_cell[3];
            mem_cell[4] <= mem_cell[4];
            mem_cell[5] <= mem_cell[5];
            mem_cell[6] <= mem_cell[6];
            mem_cell[7] <= mem_cell[7];
            mem_cell[8] <= mem_cell[8];
            mem_cell[9] <= mem_cell[9];
            mem_cell[10] <= mem_cell[10];
            mem_cell[11] <= mem_cell[11];
            mem_cell[12] <= mem_cell[12];
            mem_cell[13] <= mem_cell[13];
            mem_cell[14] <= mem_cell[14];
            mem_cell[15] <= mem_cell[15];
            mem_cell[16] <= mem_cell[16];
            mem_cell[17] <= mem_cell[17];
            mem_cell[18] <= mem_cell[18];
            mem_cell[19] <= mem_cell[19];
            mem_cell[20] <= mem_cell[20];
            mem_cell[21] <= mem_cell[21];
            mem_cell[22] <= mem_cell[22];
            mem_cell[23] <= mem_cell[23];
            mem_cell[24] <= mem_cell[24];
            mem_cell[25] <= mem_cell[25];
            mem_cell[26] <= mem_cell[26];
            mem_cell[27] <= mem_cell[27];
            mem_cell[28] <= mem_cell[28];
            mem_cell[29] <= mem_cell[29];
            mem_cell[30] <= mem_cell[30];
            mem_cell[31] <= mem_cell[31];
            mem_cell[32] <= mem_cell[32];
            mem_cell[33] <= mem_cell[33];
            mem_cell[34] <= mem_cell[34];
            mem_cell[35] <= mem_cell[35];
            mem_cell[36] <= mem_cell[36];
            mem_cell[37] <= mem_cell[37];
            mem_cell[38] <= mem_cell[38];
            mem_cell[39] <= mem_cell[39];
        end
    end
    assign inst = {mem_cell[pc+3], mem_cell[pc+2], mem_cell[pc+1], mem_cell[pc]};
endmodule
    module data_mem (
        input clk, rst_n, 
        input [1:0] memRW,
        input [31:0] addr, data_in,
        output reg [31:0] data_out
    );
        localparam read_mem = 2'b01;
        localparam write_mem = 2'b10;
        localparam no_access = 2'b00;
        
        
        reg [7:0] mem_cell [79:0];

        always @(posedge clk or negedge rst_n) begin
            if(!rst_n) begin
                mem_cell[0] <= 8'h0;
                mem_cell[1] <= 8'h0;
                mem_cell[2] <= 8'h0;
                mem_cell[3] <= 8'h0;
                mem_cell[4] <= 8'h0;
                mem_cell[5] <= 8'h0;
                mem_cell[6] <= 8'h0;
                mem_cell[7] <= 8'h0;
                mem_cell[8] <= 8'h64;
                mem_cell[9] <= 8'h0;
                mem_cell[10] <= 8'h0;
                mem_cell[11] <= 8'h0;
                mem_cell[12] <= 8'h0;
                mem_cell[13] <= 8'h0;
                mem_cell[14] <= 8'h0;
                mem_cell[15] <= 8'h0;
                mem_cell[16] <= 8'h0;
                mem_cell[17] <= 8'h0;
                mem_cell[18] <= 8'h0;
                mem_cell[19] <= 8'h0;
                mem_cell[20] <= 8'h0;
                mem_cell[21] <= 8'h0;
                mem_cell[22] <= 8'h0;
                mem_cell[23] <= 8'h0;
                mem_cell[24] <= 8'h0;
                mem_cell[25] <= 8'h0;
                mem_cell[26] <= 8'h0;
                mem_cell[27] <= 8'h0;
                mem_cell[28] <= 8'h0;
                mem_cell[29] <= 8'h0;
                mem_cell[30] <= 8'h0;
                mem_cell[31] <= 8'h0;
                mem_cell[32] <= 8'h0;
                mem_cell[33] <= 8'h0;
                mem_cell[34] <= 8'h0;
                mem_cell[35] <= 8'h0;
                mem_cell[36] <= 8'h0;
                mem_cell[37] <= 8'h0;
                mem_cell[38] <= 8'h0;
                mem_cell[39] <= 8'h0;
                mem_cell[40] <= 8'h0;
                mem_cell[41] <= 8'h0;
                mem_cell[42] <= 8'h0;
                mem_cell[43] <= 8'h0;
                mem_cell[44] <= 8'h0;
                mem_cell[45] <= 8'h0;
                mem_cell[46] <= 8'h0;
                mem_cell[47] <= 8'h0;
                mem_cell[48] <= 8'h0;
                mem_cell[49] <= 8'h0;
                mem_cell[50] <= 8'h0;
                mem_cell[51] <= 8'h0;
                mem_cell[52] <= 8'h0;
                mem_cell[53] <= 8'h0;
                mem_cell[54] <= 8'h0;
                mem_cell[55] <= 8'h0;
                mem_cell[56] <= 8'h0;
                mem_cell[57] <= 8'h0;
                mem_cell[58] <= 8'h0;
                mem_cell[59] <= 8'h0;
                mem_cell[60] <= 8'h0;
                mem_cell[61] <= 8'h0;
                mem_cell[62] <= 8'h0;
                mem_cell[63] <= 8'h0;
                mem_cell[64] <= 8'h0;
                mem_cell[65] <= 8'h0;
                mem_cell[66] <= 8'h0;
                mem_cell[67] <= 8'h0;
                mem_cell[68] <= 8'h0;
                mem_cell[69] <= 8'h0;
                mem_cell[70] <= 8'h0;
                mem_cell[71] <= 8'h0;
                mem_cell[72] <= 8'h0;
                mem_cell[73] <= 8'h0;
                mem_cell[74] <= 8'h0;
                mem_cell[75] <= 8'h0;
                mem_cell[76] <= 8'h0;
                mem_cell[77] <= 8'h0;
                mem_cell[78] <= 8'h0;
                mem_cell[79] <= 8'h0;
            end
            else begin //memRW = 0: Read, 1: Write
                if(memRW == write_mem) begin
                    mem_cell[addr] <= data_in[7:0];
                    mem_cell[addr+1] <= data_in[15:8];
                    mem_cell[addr+2] <= data_in[23:16];
                    mem_cell[addr+3] <= data_in[31:24];
                end
                else begin
                    mem_cell[addr] <= mem_cell[addr];
                    mem_cell[addr+1] <= mem_cell[addr+1];
                    mem_cell[addr+2] <= mem_cell[addr+2];
                    mem_cell[addr+3] <= mem_cell[addr+3];
                end
            end
        end
        always @(addr) begin
            if(memRW == read_mem) begin
                data_out[7:0] <= mem_cell[addr];
                data_out[15:8] <= mem_cell[addr+1];
                data_out[23:16] <= mem_cell[addr+2];
                data_out[31:24] <= mem_cell[addr+3];
            end
            else begin
                data_out[7:0] <= 8'b0;
                data_out[15:8] <= 8'b0;
                data_out[23:16] <= 8'b0;
                data_out[31:24] <= 8'b0;
            end
            
        end
    endmodule
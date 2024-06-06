module wb_sel (
    input [1:0] WBsel,
    input [31:0] ALU_out, data_out, pc_added,
    output [31:0] WB_Data
);
    //WB param
    localparam data_mem_sel = 2'b00;
    localparam alu_out_sel = 2'b01;
    localparam pc_addr_sel = 2'b10;
    localparam no_WB = 2'b11;
    
    assign WB_Data = (WBsel == data_mem_sel) ? data_out :
                     (WBsel == alu_out_sel) ? ALU_out : 
                     (WBsel == pc_addr_sel) ? pc_added : 32'b0;
endmodule
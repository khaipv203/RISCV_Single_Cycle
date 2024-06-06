module PC (
    input clk, rst_n, pc_sel,
    input [31:0] pc_wb,
    input [31:0] pc_added,
    output reg [31:0] pc
);  
    reg [31:0] pc_next;
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            pc_next = 32'h00000000;
        end
        else if(pc_next > 32'h00000023) begin
            pc_next = 32'h00000024;
        end
        else begin
            if(pc_sel) begin
                pc_next = pc_wb;
            end
            else begin
                pc_next = pc_added;
            end
        end
        pc = pc_next;
    end
endmodule
module pc_adder (
    input [31:0] pc,
    output [31:0] pc_added
);
    assign pc_added = pc + 4;
endmodule
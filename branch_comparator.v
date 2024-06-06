module branch_comparator (
    input [31:0] DataA, DataB,
    input BrUn,
    output reg BrLT, BrEq
);
    always @(DataA or DataB) begin
        if(DataA == DataB) begin
            BrEq <= 1'b1;
            BrLT <= 1'b0;
        end
        else begin
            BrEq <= 1'b0;
            if(BrUn == 1'b1) begin
                BrLT <= (DataA < DataB) ? 1'b1 : 1'b0;
            end
            else begin
                if(DataA[31] ^ DataB[31]) begin
                    BrLT <= (DataA[31] == 1'b1) ? 1'b1 : 1'b0;
                end
                else begin
                    BrLT <= (DataA < DataB) ? 1'b1 : 1'b0;
                end
            end
        end
    end
    
endmodule
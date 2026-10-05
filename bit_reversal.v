module bit_reversal(
    input [2:0] in_addr,
    output [2:0] out_addr
);
    assign out_addr = {in_addr[0], in_addr[1], in_addr[2]};
endmodule
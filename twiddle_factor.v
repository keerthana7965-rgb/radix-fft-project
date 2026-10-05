module twiddle_factor (
    input [1:0] index,            // 4 Twiddle factors (0 to 3)
    output reg signed [15:0] wr,  // Real part
    output reg signed [15:0] wi   // Imaginary part
);
    always @(*) begin
        case(index)
            2'b00: begin wr = 16'd4096;  wi = 16'd0;     end // W8^0 = 1
            2'b01: begin wr = 16'd2896;  wi = -16'd2896; end // W8^1 = 0.707 - j0.707
            2'b10: begin wr = 16'd0;     wi = -16'd4096; end // W8^2 = -j
            2'b11: begin wr = -16'd2896; wi = -16'd2896; end // W8^3 = -0.707 - j0.707
            default: begin wr = 16'd4096; wi = 16'd0;    end
        endcase
    end
endmodule
module complex_multiplier (
    input signed [15:0] br, bi, // Input B (Real, Imag)
    input signed [15:0] wr, wi, // Twiddle factor W (Real, Imag)
    output signed [15:0] bwr, bwi // Output (B * W)
);
    reg signed [31:0] mul_ac, mul_bd, mul_ad, mul_bc;
    wire signed [31:0] real_sub, imag_add;

    always @(*) begin
        mul_ac = br * wr;
        mul_bd = bi * wi;
        mul_ad = br * wi;
        mul_bc = bi * wr;
    end
    
    // நெகட்டிவ் எண்கள் சரியாக ஷிப்ட் ஆக தனித்தனியாக signed ஒயர்களில் பிரிக்கிறோம்
    assign real_sub = mul_ac - mul_bd;
    assign imag_add = mul_ad + mul_bc;

    // இப்போ பிட்கள் சரியாக கட் ஆகும்
    assign bwr = real_sub[27:12];
    assign bwi = imag_add[27:12];
    
endmodule
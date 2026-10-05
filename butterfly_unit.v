module butterfly_unit (
    input signed [15:0] ar, ai,   // Input A (Real, Imag)
    input signed [15:0] bwr, bwi, // Product from Complex Multiplier (B*W)
    output signed [15:0] yr0, yi0, // Output Y0 = A + B*W
    output signed [15:0] yr1, yi1  // Output Y1 = A - B*W
);
    assign yr0 = ar + bwr;
    assign yi0 = ai + bwi;
    assign yr1 = ar - bwr;
    assign yi1 = ai - bwi;
endmodule
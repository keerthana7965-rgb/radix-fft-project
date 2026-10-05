module fft_top_architecture (
    input signed [15:0] x0, x1, x2, x3, x4, x5, x6, x7, // 8 Real Inputs
    output signed [15:0] X0_r, X0_i, X1_r, X1_i, X2_r, X2_i, X3_r, X3_i, // Outputs
    output signed [15:0] X4_r, X4_i, X5_r, X5_i, X6_r, X6_i, X7_r, X7_i
);
    // Twiddle constants coded locally for structural convenience
    wire signed [15:0] W0_r = 16'd4096,  W0_i = 16'd0;
    wire signed [15:0] W1_r = 16'd2896,  W1_i = -16'd2896;
    wire signed [15:0] W2_r = 16'd0,     W2_i = -16'd4096;
    wire signed [15:0] W3_r = -16'd2896, W3_i = -16'd2896;

    // Interstage Wires
    wire signed [15:0] s1r0, s1i0, s1r1, s1i1, s1r2, s1i2, s1r3, s1i3;
    wire signed [15:0] s1r4, s1i4, s1r5, s1i5, s1r6, s1i6, s1r7, s1i7;
    wire signed [15:0] s2r0, s2i0, s2r1, s2i1, s2r2, s2i2, s2r3, s2i3;
    wire signed [15:0] s2r4, s2i4, s2r5, s2i5, s2r6, s2i6, s2r7, s2i7;
    
    // Internal Multiplier Wires
    wire signed [15:0] m_r[0:7], m_i[0:7];

    // -------------------------------------------------------------------------
    // STAGE 1: (Using Multipliers and Butterflies structural instances)
    // -------------------------------------------------------------------------
    complex_multiplier m1_1 (x4, 16'd0, W0_r, W0_i, m_r[0], m_i[0]);
    butterfly_unit     b1_1 (x0, 16'd0, m_r[0], m_i[0], s1r0, s1i0, s1r1, s1i1);
    
    complex_multiplier m1_2 (x6, 16'd0, W0_r, W0_i, m_r[1], m_i[1]);
    butterfly_unit     b1_2 (x2, 16'd0, m_r[1], m_i[1], s1r2, s1i2, s1r3, s1i3);

    complex_multiplier m1_3 (x5, 16'd0, W0_r, W0_i, m_r[2], m_i[2]);
    butterfly_unit     b1_3 (x1, 16'd0, m_r[2], m_i[2], s1r4, s1i4, s1r5, s1i5);

    complex_multiplier m1_4 (x7, 16'd0, W0_r, W0_i, m_r[3], m_i[3]);
    butterfly_unit     b1_4 (x3, 16'd0, m_r[3], m_i[3], s1r6, s1i6, s1r7, s1i7);

    // -------------------------------------------------------------------------
    // STAGE 2:
    // -------------------------------------------------------------------------
    complex_multiplier m2_1 (s1r2, s1i2, W0_r, W0_i, m_r[4], m_i[4]);
    butterfly_unit     b2_1 (s1r0, s1i0, m_r[4], m_i[4], s2r0, s2i0, s2r2, s2i2);

    complex_multiplier m2_2 (s1r3, s1i3, W2_r, W2_i, m_r[5], m_i[5]);
    butterfly_unit     b2_2 (s1r1, s1i1, m_r[5], m_i[5], s2r1, s2i1, s2r3, s2i3);

    complex_multiplier m2_3 (s1r6, s1i6, W0_r, W0_i, m_r[6], m_i[6]);
    butterfly_unit     b2_3 (s1r4, s1i4, m_r[6], m_i[6], s2r4, s2i4, s2r6, s2i6);

    complex_multiplier m2_4 (s1r7, s1i7, W2_r, W2_i, m_r[7], m_i[7]);
    butterfly_unit     b2_4 (s1r5, s1i5, m_r[7], m_i[7], s2r5, s2i5, s2r7, s2i7);

    // -------------------------------------------------------------------------
    // STAGE 3: Final Outputs
    // -------------------------------------------------------------------------
    wire signed [15:0] f_r[0:3], f_i[0:3];
    complex_multiplier m3_1 (s2r4, s2i4, W0_r, W0_i, f_r[0], f_i[0]);
    butterfly_unit     b3_1 (s2r0, s2i0, f_r[0], f_i[0], X0_r, X0_i, X4_r, X4_i);

    complex_multiplier m3_2 (s2r5, s2i5, W1_r, W1_i, f_r[1], f_i[1]);
    butterfly_unit     b3_2 (s2r1, s2i1, f_r[1], f_i[1], X1_r, X1_i, X5_r, X5_i);

    complex_multiplier m3_3 (s2r6, s2i6, W2_r, W2_i, f_r[2], f_i[2]);
    butterfly_unit     b3_3 (s2r2, s2i2, f_r[2], f_i[2], X2_r, X2_i, X6_r, X6_i);

    complex_multiplier m3_4 (s2r7, s2i7, W3_r, W3_i, f_r[3], f_i[3]);
    butterfly_unit     b3_4 (s2r3, s2i3, f_r[3], f_i[3], X3_r, X3_i, X7_r, X7_i);

endmodule
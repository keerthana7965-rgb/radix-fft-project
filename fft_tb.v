module fft_tb;

    // Inputs to Top-Level Module
    reg signed [15:0] x0, x1, x2, x3, x4, x5, x6, x7;

    // Outputs from Top-Level Module
    wire signed [15:0] X0_r, X0_i, X1_r, X1_i, X2_r, X2_i, X3_r, X3_i;
    wire signed [15:0] X4_r, X4_i, X5_r, X5_i, X6_r, X6_i, X7_r, X7_i;

    // -------------------------------------------------------------------------
    // UNIT UNDER TEST (UUT) - TOP LEVEL ARCHITECTURE INTERACTION
    // -------------------------------------------------------------------------
    fft_top_architecture uut (
        .x0(x0), .x1(x1), .x2(x2), .x3(x3), .x4(x4), .x5(x5), .x6(x6), .x7(x7),
        .X0_r(X0_r), .X0_i(X0_i), .X1_r(X1_r), .X1_i(X1_i), 
        .X2_r(X2_r), .X2_i(X2_i), .X3_r(X3_r), .X3_i(X3_i),
        .X4_r(X4_r), .X4_i(X4_i), .X5_r(X5_r), .X5_i(X5_i), 
        .X6_r(X6_r), .X6_i(X6_i), .X7_r(X7_r), .X7_i(X7_i)
    );

    initial begin
        // =========================================================================
        // INPUT SETTING: Fixed Point Q4.12 values (Original Input * 4096)
        // =========================================================================
        // x(n) = {1, 2, 3, 4, 5, 6, 7, 8}
        x0 = 16'd4096;   // 1 * 4096
        x1 = 16'd8192;   // 2 * 4096
        x2 = 16'd12288;  // 3 * 4096
        x3 = 16'd16384;  // 4 * 4096
        x4 = 16'd20480;  // 5 * 4096
        x5 = 16'd24576;  // 6 * 4096
        x6 = 16'd28672;  // 7 * 4096
        x7 = 16'd32768;  // 8 * 4096

        // Wait 100ns for output settling
        #100;

        // =========================================================================
        // CONSOLE DISPLAY LOGIC
        // =========================================================================
        $display("\n==================================================================");
        $display("          8-POINT RADIX-2 DIT FFT SIMULATION OUTPUTS             ");
        $display("==================================================================");
        $display("Input Sequence x(n) = {1, 2, 3, 4, 5, 6, 7, 8}\n");
        
        // $strobe reflects accurate values after all variations settle down
        $strobe("X(0) -> Real: %d, Imag: %d (Expected: 36, 0)", X0_r/4096, X0_i/4096);
        $strobe("X(1) -> Real: %d, Imag: %d (Expected: -4, 9.657)", X1_r/4096, X1_i/4096);
        $strobe("X(2) -> Real: %d, Imag: %d (Expected: -4, 4)", X2_r/4096, X2_i/4096);
        $strobe("X(3) -> Real: %d, Imag: %d (Expected: -4, 1.657)", X3_r/4096, X3_i/4096);
        $strobe("X(4) -> Real: %d, Imag: %d (Expected: -4, 0)", X4_r/4096, X4_i/4096);
        $strobe("X(5) -> Real: %d, Imag: %d (Expected: -4, -1.657)", X5_r/4096, X5_i/4096);
        $strobe("X(6) -> Real: %d, Imag: %d (Expected: -4, -4)", X6_r/4096, X6_i/4096);
        $strobe("X(7) -> Real: %d, Imag: %d (Expected: -4, -9.657)", X7_r/4096, X7_i/4096);
        $display("==================================================================\n");
        
        #10;
        $finish;
    end

endmodule
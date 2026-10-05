module fft_control (
    input clk,
    input reset,
    output reg [1:0] current_stage,
    output reg done
);
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_stage <= 2'b01; // Stage 1
            done <= 1'b0;
        end else begin
            if (current_stage == 2'b11) begin
                done <= 1'b1;       // Stage 3 
            end else begin
                current_stage <= current_stage + 1;
            end
        end
    end
endmodule
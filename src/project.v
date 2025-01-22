/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_half_adder (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

    // Internal signals for sum and carry
    wire [7:0] sum;
    wire [7:0] carry;

    // Half Adder Logic: Sum = A XOR B, Carry = A AND B
    assign sum = ui_in ^ uio_in;  // XOR for sum
    assign carry = ui_in & uio_in; // AND for carry

    // Assign outputs
    assign uo_out = sum;          // Send sum to the output
    assign uio_out = sum;         // Send sum to the IO output path
    assign uio_oe = {8{ena}};     // Enable IO outputs if ena is high, else input

    // Reset and Clock Handling
    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            // Reset logic (in case of reset)
            uo_out <= 8'b0;
            uio_out <= 8'b0;
        end else begin
            // Normal operation (no reset)
            // You can place any additional logic here if needed
        end
    end

endmodule


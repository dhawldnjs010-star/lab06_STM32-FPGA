`timescale 1ns/1ps
// STM32_2 과제6·7 FPGA 쪽 (학생 작성). LAB3 UART 에코(lab3_uart_echo)를 바탕으로 했다.
// - RX: MCU PC10(TX)에서 오는 9600 8N1을 확장 커넥터 EX2 5번(EXT0, G10)으로 받는다.
// - TX: 받은 바이트를 그대로 F6(보드 USB-UART)로 PC에 보낸다. (과제6)
// - 명령: '0'(0x30) 끄기, '1'(0x31) 켜기, '2'(0x32) 반전, 그 밖의 문자는 유지. (과제7)
module uart_cmd #(
    parameter integer CLK_HZ = 50_000_000,
    parameter integer BAUD = 9_600
) (
    input  wire clk_50mhz,
    input  wire rst_p,
    input  wire uart_rxd,
    output wire uart_txd,
    output reg  cmd_led
);
    localparam integer DIV = (CLK_HZ + BAUD/2) / BAUD;
    wire [7:0] rx_data;
    wire rx_valid, rx_framing_error, tx_ready;
    reg tx_valid;
    reg [7:0] tx_data;

    uart_rx #(.DIV(DIV)) u_rx(
        .clk(clk_50mhz), .rst_p(rst_p), .rx(uart_rxd), .data(rx_data),
        .valid(rx_valid), .framing_error(rx_framing_error));
    uart_tx #(.DIV(DIV)) u_tx(
        .clk(clk_50mhz), .rst_p(rst_p), .valid(tx_valid), .data(tx_data),
        .ready(tx_ready), .tx(uart_txd));

    always @(posedge clk_50mhz or posedge rst_p) begin
        if (rst_p) begin
            tx_valid <= 0; tx_data <= 0; cmd_led <= 0;
        end else begin
            tx_valid <= 0;
            if (rx_valid) begin
                if (tx_ready) begin tx_data <= rx_data; tx_valid <= 1; end
                case (rx_data)
                    8'h30: cmd_led <= 1'b0;      // '0'
                    8'h31: cmd_led <= 1'b1;      // '1'
                    8'h32: cmd_led <= ~cmd_led;  // '2'
                    default: ;                   // 유지
                endcase
            end
        end
    end
endmodule

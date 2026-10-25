# lab06 STM32_2 과제6·7 - FPGA UART 수신과 LED 명령 (uart_cmd)

`uart_cmd(clk_50mhz, rst_p, uart_rxd, uart_txd, cmd_led)`, 9600 8N1 (1비트 = 5208클록).
MCU PC10(TX)에서 받은 바이트를 그대로 F6(USB-UART)로 PC에 보내고(과제6), '0' 끄기 / '1' 켜기 / '2' 반전 / 그 밖 유지로 LED_D1을 바꾼다(과제7).

| 경로 | 내용 |
|---|---|
| src/uart.v | 조교 LAB3 UART 에코 예제의 uart_rx·uart_tx 그대로 |
| src/uart_cmd.v | 최상위 (학생 작성, lab3_uart_echo 바탕) |
| sim/tb.sv | 학생 작성 TB: "1122x0"과 0x01을 보내 되돌아오는 바이트와 LED 확인 |
| constraints/pins.xdc | RX G10(EX2 5번), TX F6, LED_D1 L4, rst SW_1 |
| evidence/pre/ | PASS 로그, 파형, 오류 주입('2'를 켜기로 바꾸면 FATAL) |

연결: MCU PC10 → EX2 5번, MCU GND → EX2 45번. PC에서 MCU COM 포트로 보내고 FPGA COM 포트에서 확인한다.

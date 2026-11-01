# STM32_2 과제6·7 FPGA 쪽 (최상위: uart_cmd), 9600 8N1
# 핀 출처: 조교 LAB3 lab3_uart_echo.xdc (B6, K4, F6), Xilinx S7 Pin Map의 BreadBoard I/O 표 (BDIO00 = F8)
# 연결: MCU PC10(TX, CN7 1번) -> 브레드보드 영역 PORT A의 I/O 00, MCU GND(CN7 8번) -> 같은 영역의 GND 헤더.
#       보드의 PORT A ENABLE 스위치를 켠다. FPGA TX F6 -> 보드 USB-UART -> PC
# 기존 LAB3의 RX C6(보드 USB-UART)은 쓰지 않는다. (확장 커넥터 EX1·EX2는 신호등 모듈이 쓰고 있어 브레드보드 I/O로 정했다)
set_property PACKAGE_PIN B6  [get_ports clk_50mhz]
set_property PACKAGE_PIN K4  [get_ports rst_p]      ;# SW_1
set_property PACKAGE_PIN F8  [get_ports uart_rxd]   ;# PORT A I/O 00 (BDIO00) <- MCU PC10
set_property PACKAGE_PIN F6  [get_ports uart_txd]   ;# USB-UART -> PC
set_property PACKAGE_PIN L4  [get_ports cmd_led]    ;# LED_D1
set_property IOSTANDARD LVCMOS33 [get_ports *]
set_property PULLUP true [get_ports uart_rxd]       ;# 선을 뺐을 때 유휴(HIGH) 유지
create_clock -name clk_50mhz -period 20.000 [get_ports clk_50mhz]
set_false_path -from [get_ports {rst_p uart_rxd}]

# STM32_2 FPGA 실습 1 - 서보모터 (구현 최상위: servo_board, 내부에 수업 제공 servo_ctrl 사용)
# 핀 출처: Xilinx S7 Pin Map (Servo Motor SERVO_CTRL AA22), 버튼·LED는 lab05와 같음
# 버튼은 누르면 HIGH. KEYPADS SEL 스위치를 아래로 내려 버튼 모드로 쓴다.
set_property PACKAGE_PIN B6   [get_ports clk_50mhz]
set_property PACKAGE_PIN K6   [get_ports rst_p]      ;# SW_#
set_property PACKAGE_PIN K4   [get_ports btn_left]   ;# SW_1: 0.1 ms 줄이기
set_property PACKAGE_PIN N8   [get_ports btn_right]  ;# SW_2: 0.1 ms 늘리기
set_property PACKAGE_PIN AA22 [get_ports servo]      ;# SERVO_CTRL
set_property PACKAGE_PIN L4  [get_ports {led_out[7]}]   ;# LED_D1
set_property PACKAGE_PIN M4  [get_ports {led_out[6]}]   ;# LED_D2
set_property PACKAGE_PIN M2  [get_ports {led_out[5]}]   ;# LED_D3
set_property PACKAGE_PIN N7  [get_ports {led_out[4]}]   ;# LED_D4
set_property PACKAGE_PIN M7  [get_ports {led_out[3]}]   ;# LED_D5
set_property PACKAGE_PIN M3  [get_ports {led_out[2]}]   ;# LED_D6
set_property PACKAGE_PIN M1  [get_ports {led_out[1]}]   ;# LED_D7
set_property PACKAGE_PIN N5  [get_ports {led_out[0]}]   ;# LED_D8
set_property IOSTANDARD LVCMOS33 [get_ports *]
create_clock -name clk_50mhz -period 20.000 [get_ports clk_50mhz]
set_false_path -from [get_ports {rst_p btn_left btn_right}]

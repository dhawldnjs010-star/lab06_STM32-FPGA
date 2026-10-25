# STM32_2 FPGA 실습 2 - SRAM 읽기·쓰기 (최상위: sram, 클록 없는 조합회로)
# 핀 출처: Xilinx S7 Pin Map의 SRAM 표 (CSN N20, OEN L21, WEN U17, A[17:0], D[15:0]), DIP은 HBE Combo II-DLD 설명서
# 쓰기: DIP_SW1~4로 주소, DIP_SW5~8로 값을 정하고 SW_1을 누른다. 읽기: 주소를 정하고 SW_2를 누르는 동안 LED5~8에 값.
set_property PACKAGE_PIN K4 [get_ports ctrl_w]   ;# SW_1 쓰기
set_property PACKAGE_PIN N8 [get_ports ctrl_r]   ;# SW_2 읽기
set_property PACKAGE_PIN Y1 [get_ports {address[3]}] ;# DIP_SW1
set_property PACKAGE_PIN W3 [get_ports {address[2]}] ;# DIP_SW2
set_property PACKAGE_PIN U2 [get_ports {address[1]}] ;# DIP_SW3
set_property PACKAGE_PIN T1 [get_ports {address[0]}] ;# DIP_SW4
set_property PACKAGE_PIN W4 [get_ports {data_in[3]}] ;# DIP_SW5
set_property PACKAGE_PIN W1 [get_ports {data_in[2]}] ;# DIP_SW6
set_property PACKAGE_PIN V4 [get_ports {data_in[1]}] ;# DIP_SW7
set_property PACKAGE_PIN U4 [get_ports {data_in[0]}] ;# DIP_SW8
set_property PACKAGE_PIN N20 [get_ports ram_cs]  ;# SRAM_CSN (LOW 활성)
set_property PACKAGE_PIN L21 [get_ports ram_oe]  ;# SRAM_OEN
set_property PACKAGE_PIN U17 [get_ports ram_we]  ;# SRAM_WEN
set_property PACKAGE_PIN L20 [get_ports {ram_address[0]}]
set_property PACKAGE_PIN L22 [get_ports {ram_address[1]}]
set_property PACKAGE_PIN M17 [get_ports {ram_address[2]}]
set_property PACKAGE_PIN M18 [get_ports {ram_address[3]}]
set_property PACKAGE_PIN N18 [get_ports {ram_address[4]}]
set_property PACKAGE_PIN W22 [get_ports {ram_address[5]}]
set_property PACKAGE_PIN V22 [get_ports {ram_address[6]}]
set_property PACKAGE_PIN V20 [get_ports {ram_address[7]}]
set_property PACKAGE_PIN V18 [get_ports {ram_address[8]}]
set_property PACKAGE_PIN U20 [get_ports {ram_address[9]}]
set_property PACKAGE_PIN V19 [get_ports {ram_address[10]}]
set_property PACKAGE_PIN U22 [get_ports {ram_address[11]}]
set_property PACKAGE_PIN U19 [get_ports {ram_address[12]}]
set_property PACKAGE_PIN T21 [get_ports {ram_address[13]}]
set_property PACKAGE_PIN T19 [get_ports {ram_address[14]}]
set_property PACKAGE_PIN L19 [get_ports {ram_address[15]}]
set_property PACKAGE_PIN L16 [get_ports {ram_address[16]}]
set_property PACKAGE_PIN K19 [get_ports {ram_address[17]}]
set_property PACKAGE_PIN P17 [get_ports {ram_data[0]}]
set_property PACKAGE_PIN P21 [get_ports {ram_data[1]}]
set_property PACKAGE_PIN R16 [get_ports {ram_data[2]}]
set_property PACKAGE_PIN R18 [get_ports {ram_data[3]}]
set_property PACKAGE_PIN R20 [get_ports {ram_data[4]}]
set_property PACKAGE_PIN T17 [get_ports {ram_data[5]}]
set_property PACKAGE_PIN T20 [get_ports {ram_data[6]}]
set_property PACKAGE_PIN T22 [get_ports {ram_data[7]}]
set_property PACKAGE_PIN T16 [get_ports {ram_data[8]}]
set_property PACKAGE_PIN R19 [get_ports {ram_data[9]}]
set_property PACKAGE_PIN R17 [get_ports {ram_data[10]}]
set_property PACKAGE_PIN P22 [get_ports {ram_data[11]}]
set_property PACKAGE_PIN P20 [get_ports {ram_data[12]}]
set_property PACKAGE_PIN P16 [get_ports {ram_data[13]}]
set_property PACKAGE_PIN N19 [get_ports {ram_data[14]}]
set_property PACKAGE_PIN M16 [get_ports {ram_data[15]}]
set_property PACKAGE_PIN L4  [get_ports {led_out[7]}]   ;# LED_D1
set_property PACKAGE_PIN M4  [get_ports {led_out[6]}]   ;# LED_D2
set_property PACKAGE_PIN M2  [get_ports {led_out[5]}]   ;# LED_D3
set_property PACKAGE_PIN N7  [get_ports {led_out[4]}]   ;# LED_D4
set_property PACKAGE_PIN M7  [get_ports {led_out[3]}]   ;# LED_D5
set_property PACKAGE_PIN M3  [get_ports {led_out[2]}]   ;# LED_D6
set_property PACKAGE_PIN M1  [get_ports {led_out[1]}]   ;# LED_D7
set_property PACKAGE_PIN N5  [get_ports {led_out[0]}]   ;# LED_D8
set_property IOSTANDARD LVCMOS33 [get_ports *]

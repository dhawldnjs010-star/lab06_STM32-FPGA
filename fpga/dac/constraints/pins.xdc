# STM32_2 FPGA 실습 3 - DAC (최상위: dac). 0~255 계단파를 10 ms마다 한 단계씩 (한 바퀴 2.56 s)
# 핀 출처: Xilinx S7 Pin Map의 DA Converter 표 (DAC_A_B G2, CSN E1, LDACN F4, WRN G4, D0~D7)
# 보드의 DAC CH0 전압계(Volt-Meter)와 LED로 값 변화를 본다 (HBE Combo II-DLD 설명서).
set_property PACKAGE_PIN B6 [get_ports clk_50mhz]
set_property PACKAGE_PIN K4 [get_ports rst_p]      ;# SW_1
set_property PACKAGE_PIN Y1 [get_ports add_sel]    ;# DIP_SW1: 0 = A 채널, 1 = B 채널
set_property PACKAGE_PIN E1 [get_ports dac_csn]
set_property PACKAGE_PIN F4 [get_ports dac_ldacn]
set_property PACKAGE_PIN G4 [get_ports dac_wen]    ;# DAC_WRN
set_property PACKAGE_PIN G2 [get_ports dac_a_b]
set_property PACKAGE_PIN E3 [get_ports {dac_d[0]}]
set_property PACKAGE_PIN E5 [get_ports {dac_d[1]}]
set_property PACKAGE_PIN D2 [get_ports {dac_d[2]}]
set_property PACKAGE_PIN D5 [get_ports {dac_d[3]}]
set_property PACKAGE_PIN C2 [get_ports {dac_d[4]}]
set_property PACKAGE_PIN C4 [get_ports {dac_d[5]}]
set_property PACKAGE_PIN B1 [get_ports {dac_d[6]}]
set_property PACKAGE_PIN B3 [get_ports {dac_d[7]}]
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
set_false_path -from [get_ports {rst_p add_sel}]

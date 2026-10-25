# lab06 FPGA 3 - DAC (dac)

`dac(clk_50mhz, rst_p, add_sel, dac_csn, dac_ldacn, dac_wen, dac_a_b, dac_d[7:0], led_out[7:0])`.
500,000클록(10 ms)마다 값을 1 올려 0~255를 반복하고(한 바퀴 2.56 s), 값을 먼저 둔 뒤 한 클록 LOW 쓰기 펄스를 낸다.

| 경로 | 내용 |
|---|---|
| src/dac.v, dac_parallel8.v, ramp8.v | 수업 제공 설계 |
| sim/tb.sv | 수업 제공 TB (UPDATE_CYCLES=4), 파형 저장 두 줄 추가 |
| constraints/pins.xdc | DAC_A_B G2, CSN E1, LDACN F4, WRN G4, D0~D7, DIP_SW1 채널, SW_1 리셋, LED 8개 |
| evidence/pre/ | PASS 로그, 파형, 오류 주입(펄스 끝에 데이터를 바꾸면 FATAL) |

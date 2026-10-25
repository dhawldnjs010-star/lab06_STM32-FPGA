# lab06 FPGA 2 - SRAM 읽기·쓰기 (sram)

`sram(ctrl_w, ctrl_r, address[3:0], data_in[3:0], ram_cs, ram_oe, ram_we, ram_address[17:0], ram_data[15:0], led_out[7:0])`, 클록 없는 조합회로.
쓰기 때만 FPGA가 데이터 버스를 구동하고, 읽기 때는 Z로 놓아 SRAM 값을 LED 하위 4비트에 낸다. 동시 요청은 무시한다.

| 경로 | 내용 |
|---|---|
| src/sram.v, sram_bus_control.v | 수업 제공 설계 |
| sim/tb.sv | 수업 제공 TB (SRAM 모델 포함), 파형 저장 두 줄 추가 |
| constraints/pins.xdc | SRAM_CSN N20, OEN L21, WEN U17, A[17:0], D[15:0], DIP_SW1~4 주소, DIP_SW5~8 값, SW_1 쓰기, SW_2 읽기 |
| evidence/pre/ | PASS 로그, 파형, 오류 주입(동시 요청에도 구동하면 FATAL) |

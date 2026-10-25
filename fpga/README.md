# FPGA (STM32_2 주차, 10/26)

조교 매뉴얼 `Glaysia/ece2_474` v1.1.0 `docs/STM32_2.md`와 `docs/FPGA_additional.md` 5·6·8장의 설계 모듈과 테스트벤치를
fpga-lab-template(Glaysia/fpga-lab-template, 커밋 0b3318e466e9d77f7d3880df09c827788f361913) 구조로 옮겼다.

| 폴더 | 설계 최상위 | 시뮬레이션 top | 확인할 내용 |
|---|---|---|---|
| uart_cmd | `uart_cmd` | `tb` | 과제6·7 FPGA 쪽: 확장 GPIO로 받은 바이트를 USB-UART로 PC에 출력, 명령 0/1/2로 LED 끄기·켜기·반전 |
| servo | `servo_ctrl` (보드 구현은 `servo_board`) | `tb` | 20 ms 프레임, 1~2 ms 펄스, 버튼 한 번에 0.1 ms, 제한, 리셋 |
| sram | `sram` | `tb` | 주소 0~15 쓰기·읽기, 읽을 때 버스 Z, 동시 요청 무시 |
| dac | `dac` | `tb` | 0~255 계단 값과 쓰기 펄스, 채널 선택, 데이터 유지 |

각 폴더: `src/` 설계, `sim/` TB, `constraints/pins.xdc` 핀 제약, `simulation.json`, `tools/fpga_lab.py`, `evidence/pre/` 사전 검증 기록.
servo·sram·dac의 `src/`는 수업 제공 그대로이고 TB에는 파형 저장 두 줄만 추가했다. servo의 `button_pulse.v`, `servo_board.v`, `sim/board_tb.sv`와 uart_cmd 전체(`uart.v`는 조교 LAB3 UART 에코 예제)는 학생 작성이다.

실행: 각 폴더에서 `python tools/fpga_lab.py simulate` 또는 VS Code에서 `FPGA.code-workspace` → Run Task.
Vivado: Tcl Console에서 `set ex servo` 후 `source .../fpga/vivado_setup.tcl`, 이어서 `make_bit`.

핀 출처: 예전교안모음의 `Xilinx S7 Pin Map.pdf`(SERVO_CTRL, SRAM, DA Converter, 확장 커넥터 EX2), `HBE Combo II-DLD.pdf`(DIP), 조교 LAB3 `lab3_uart_echo.xdc`.
보드에서 확인할 가정: EX2 5번 핀(G10)이 3.3 V 뱅크인지, DIP을 올리면 1인지, DAC 전압계가 A 채널(add_sel = 0)을 보이는지.

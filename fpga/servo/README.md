# lab06 FPGA 1 - 서보모터 제어 (servo)

`servo_ctrl(clk_50mhz, rst_p, left_pulse, right_pulse, servo)`: 20 ms(1,000,000클록)마다 1~2 ms HIGH 펄스. 리셋 1.5 ms, 버튼 한 번에 0.1 ms, 새 폭은 다음 프레임부터.

| 경로 | 내용 |
|---|---|
| src/servo_ctrl.v, servo_position.v, servo_pwm.v | 수업 제공 설계 |
| src/button_pulse.v, servo_board.v | 보드 구현용 (학생 추가): 버튼 → 한 클록 펄스, LED에 폭 단계 표시 |
| sim/tb.sv | 수업 제공 TB (CLK_HZ=100000), 파형 저장 두 줄 추가 |
| sim/board_tb.sv | 학생 작성 보조 TB: 떨리는 버튼 한 번 = 한 단계, 제한, LED |
| constraints/pins.xdc | SERVO_CTRL AA22, SW_1 왼쪽(-0.1 ms), SW_2 오른쪽(+0.1 ms), SW_# 리셋, LED 8개 |
| evidence/pre/ | PASS 로그, 파형, 보조 TB 로그, 오류 주입(0.2 ms씩 줄이면 FATAL) |

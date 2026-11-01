# 실험 후 레포트: STM32_2 과제6·7 FPGA 쪽 · uart_cmd

작성자 엄상혁(2025440084) / 실험일 2026-10-26 / Vivado 2026.1 / top `uart_cmd` / 보드 클록 50 MHz, 9600 8N1

## 시뮬레이션
XSim `PASS uart_cmd: echo 7 bytes, LED 0/1/2 commands, other byte hold, reset` (`xsim_wave.png`). 보낸 31 31 32 32 78 30 01에 LED 1 1 0 1 1 0 0.

## 합성·구현
RX 핀을 F8(브레드보드 PORT A I/O 00)로 바꿔 다시 구현: `write_bitstream Complete!`, WNS 14.588 ns, WHS 0.177 ns, Failed Routes 0 (`vivado_runs.png`).

## 보드 (`../../../evidence/post/stm32/task6_7_uart_fpga_demo.mp4`)
- COM5(MCU)로 1, 2, x를 보내자 MCU는 `send: 1 (0x31), result: 0` 등을 출력했고, COM6(FPGA)에 `12x`가 그대로 나왔다 (`task67_serial.jpg`).
- LED1은 11.0~12.0 s, 23.5~25.0 s, 34.0~37.5 s에 켜지고 그 사이에는 꺼졌다 (`task7_led.jpg`). 명령에 따라 켜짐·꺼짐이 바뀐 것을 확인했다.
- COM6 첫 줄의 `12x11` 뒤 깨진 두 문자는 포트를 다시 연결할 때 들어온 값으로 보인다.

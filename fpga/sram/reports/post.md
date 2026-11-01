# 실험 후 레포트: STM32_2 FPGA 실습 2 · SRAM 읽기·쓰기

작성자 엄상혁(2025440084) / 실험일 2026-10-26 / Vivado 2026.1 / top `sram` (클록 없음)

## 시뮬레이션
XSim `PASS SRAM: 16 addresses, bus release, simultaneous request` (164 ns, `xsim_wave.png`). 주소 i에 15 − i를 쓰고 다시 읽음, 읽을 때 버스 Z.

## 합성·구현
`write_bitstream Complete!`, Failed Routes 0. 클록이 없어 WNS 등 타이밍 항목은 NA. 전력 추정 7.143 W는 클록·입력 활동률 제약이 없을 때의 Vivado 기본 추정값이다 (`vivado_runs.png`).

## 보드 (`board_demo.mp4`, `sram_frames.jpg`)
DIP으로 주소·값을 정해 SW_1(쓰기) 후 SW_2(읽기)를 누르는 동안만 LED5~8에 값이 나타났다.
- 9.0~9.5 s 읽기: LED5·LED7 켜짐 → 1010 (0xA)
- 14.0 s, 16.5 s 읽기: LED7 켜짐 → 0010 (0x2)
- 읽기 버튼을 누르지 않을 때는 LED가 모두 꺼짐
DIP 위치는 영상에서 읽을 수 없어, 쓴 값과의 비교는 시연 때 눈으로 확인한 결과다.

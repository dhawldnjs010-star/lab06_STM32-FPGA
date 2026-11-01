# 실험 후 레포트: STM32_2 FPGA 실습 1 · 서보모터

작성자 엄상혁(2025440084) / 실험일 2026-10-26 / Vivado 2026.1 / 구현 top `servo_board`, 시뮬레이션 top `tb` / 보드 클록 50 MHz

## 시뮬레이션
XSim `PASS servo: 20ms frame, 1/1.5/2ms pulse, limits, reset` (100,036 ns, `xsim_wave.png`). 폭 1500(5DC) → 1000(3E8) → 2000(7D0) µs, HIGH 150 → 100 → 200클록.

## 합성·구현
`write_bitstream Complete!`, WNS 0.094 ns, WHS 0.122 ns, Failed Routes 0 (`vivado_runs.png`).

## 보드 (`board_demo.mp4`, `servo_frames.jpg`)
| 영상 시각 | LED (LED8부터 켜진 개수) | 폭 단계 | 서보 |
|---|---|---|---|
| 0.2 s | 5 (LED4~8) | 1500 µs | 가운데 |
| 5 s | 8 | 1800 µs 이상 | 한쪽으로 회전 |
| 8 s | 7 (LED2~8) | 1700 µs | |
| 10.5 s | 0 | 1000 µs | 반대쪽 끝 |
| 12.8 s | 5 | 1500 µs (리셋) | 가운데로 복귀 |

처음에는 보드 클록을 50 MHz로 두지 않아 버튼이 듣지 않았고, 클록을 050으로 맞춘 뒤 정상 동작했다.

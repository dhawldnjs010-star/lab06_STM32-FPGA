# lab06 실험 후 자료 (2026-10-26 실습)

영상은 원본(1080p HEVC)을 720p H.264로 줄이고 소리를 뺀 사본이다.

## STM32 (NUCLEO-G474RE) · `stm32/`
소스는 `Core/Src/ece2_474_routine.c` (`STM32_2_TASK` 5/6/7). 실험 때 과제5·7의 출력 문구를 영어로 바꿔 시연했고, 이 저장소에도 반영했다.

| 파일 | 내용 |
|---|---|
| `task5_pc_mcu_demo.mp4`, `task5_serial.jpg` | 과제5: Serial Monitor(COM8)로 1, A, a → `char: 1, byte: 0x31` / 0x41 / 0x61 |
| `task6_7_uart_fpga_demo.mp4`, `task67_serial.jpg` | 과제6·7: COM5(MCU)로 보낸 1, 2, x가 COM6(FPGA)에 `12x`로 출력, MCU는 `send: … result: 0` |
| `task7_led.jpg` | 과제7: 명령에 따라 LED1 켜짐·꺼짐 (영상 프레임) |
| `build_debug_demo_task5.txt`, `build_debug_demo_task7.txt` | 시연 코드 CMake Debug 빌드, 오류·경고 0 (클라우드 GNU Arm 13.2.1) |

## FPGA (Combo II-DLD, Vivado 2026.1) · `fpga/`
- `fpga/vivado_tcl_console_lab06.txt`: lab06 네 프로젝트의 Vivado Tcl 콘솔 (10/26)
- `../../fpga/<실습>/evidence/post/`: XSim 화면, 실행 결과, 시연 영상·프레임, `reports/post.md`에 실측 표

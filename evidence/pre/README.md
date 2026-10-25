# lab06 실험 전 검증 자료 (STM32_2 · PC 입출력과 STM32–FPGA UART, FPGA 서보·SRAM·DAC)

## STM32 (NUCLEO-G474RE)
- 소스: `Core/Src/ece2_474_routine.c` (`STM32_2_TASK` 5, 6, 7로 과제 선택. polling_routine 내용은 조원과 공유한 과제별 파일과 같다)
- `logs/build_debug_task5~7.txt`: CMake Debug 빌드 출력, 오류·경고 0 (클라우드 작업 환경의 GNU Arm 13.2.1)
- `fw/`: HAL 송신 함수만 흉내 낸 PC 모의 실행. Serial Monitor 입력을 파이프로 준다. `sh fw/run.sh`로 재현. 결과 `fw_log_task5~7.txt`

## FPGA (Combo II-DLD, xc7s75fgga484-1)
- `../../fpga/<실습>/evidence/pre/`: Icarus Verilog 12.0 PASS 로그, VCD, 오류 주입 로그
- 그림: `fig/fpga_wave_figs.py`

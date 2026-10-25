#!/bin/sh
# 모의 실행 재현: STM32_2_TASK를 5, 6, 7로 바꿔 PC용 gcc로 컴파일하고 Serial Monitor 입력을 파이프로 준다.
set -e
cd "$(dirname "$0")"
for t in 5 6 7; do
  case $t in 5|6) in='1Aa' ;; 7) in='1122x0' ;; esac
  sed "s/^#define STM32_2_TASK      5/#define STM32_2_TASK      $t/" ../../../Core/Src/ece2_474_routine.c > routine_t$t.c
  gcc -std=c11 -Wall -Wextra -Imock -o harness_t$t harness.c routine_t$t.c
  { echo "# input: $in (줄바꿈 없음)"; printf '%s' "$in" | ./harness_t$t; } > fw_log_task$t.txt
  rm -f routine_t$t.c harness_t$t
done

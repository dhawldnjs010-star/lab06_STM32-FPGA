/* STM32_2 과제5~7 모의 실행: 실제 ece2_474_routine.c를 그대로 컴파일한다.
 * PC Serial Monitor 입력은 표준 입력(파이프)으로 주고, printf 출력은 표준 출력으로 받는다.
 * UART3(PC10) 송신 바이트는 [UART3] 줄로 따로 기록해 FPGA TB 입력과 비교한다. */
#include <stdio.h>
#include "main.h"
#include "ece2_474.h"
TIM_TypeDef TIM6_obj; USART_TypeDef USART2_obj, USART3_obj;
TIM_HandleTypeDef htim6 = {&TIM6_obj}, htim3 = {0};
UART_HandleTypeDef huart2 = {&USART2_obj}, huart3 = {&USART3_obj};
HAL_StatusTypeDef HAL_UART_Transmit(UART_HandleTypeDef *h, const uint8_t *d, uint16_t n, uint32_t t) {
    (void)t;
    for (uint16_t i = 0; i < n; i++)
        printf("[UART%d] 0x%02X\n", h == &huart3 ? 3 : 2, d[i]);
    return HAL_OK;
}
int main(void) {
    ece2_474_init();
    for (int k = 0; k < 64; k++) polling_routine();   /* 입력이 끝나면 getchar가 EOF를 돌려준다 */
    return 0;
}

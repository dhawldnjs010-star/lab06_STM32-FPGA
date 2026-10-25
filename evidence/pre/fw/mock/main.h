/* PC 모의 실행용 main.h: ece2_474_routine.c가 쓰는 HAL 이름만 흉내 낸다. */
#ifndef MOCK_MAIN_H
#define MOCK_MAIN_H
#include <stdint.h>
typedef enum { HAL_OK = 0, HAL_ERROR = 1, HAL_BUSY = 2, HAL_TIMEOUT = 3 } HAL_StatusTypeDef;
typedef struct { int id; } GPIO_TypeDef;
typedef struct { int id; } TIM_TypeDef;
typedef struct { int id; } USART_TypeDef;
typedef struct { TIM_TypeDef *Instance; } TIM_HandleTypeDef;
typedef struct { USART_TypeDef *Instance; } UART_HandleTypeDef;
extern TIM_TypeDef TIM6_obj;
extern USART_TypeDef USART2_obj, USART3_obj;
#define TIM6 (&TIM6_obj)
#define USART2 (&USART2_obj)
#define USART3 (&USART3_obj)
#define BUTTON_ece2_Pin 0x2000U
#define GPIO_IN_PULLUP_ece2_Pin 0x0001U
#define GPIO_IN_PULLDOWN_ece2_Pin 0x0002U
HAL_StatusTypeDef HAL_UART_Transmit(UART_HandleTypeDef *h, const uint8_t *data, uint16_t size, uint32_t timeout);
#endif

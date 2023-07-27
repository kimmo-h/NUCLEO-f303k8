#include "stm32f303x8.h"
#include <stdint.h>

volatile uint32_t count = 0;

void SysTick_Handler(void) {
    count++;
}

void toggle_led(void) {
    if (!(GPIOB->ODR & GPIO_ODR_3)) {
        GPIOB->BSRR |= GPIO_BSRR_BS_3;
    }
    else {
        GPIOB->BSRR |= GPIO_BSRR_BR_3;
    }
}

void setup(void) {
    SysTick_Config(SystemCoreClock / 1000);
    RCC->AHBENR |= RCC_AHBENR_GPIOBEN;
    GPIOB->MODER &= ~GPIO_MODER_MODER3_1;
    GPIOB->MODER |= GPIO_MODER_MODER3_0;
}

int main(void) {
    setup();
    while(1) {
        if (count > 1000) {
            toggle_led();
            count = 0;
        }
    }
    return 0;
}

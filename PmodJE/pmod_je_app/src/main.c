#include "xparameters.h"
#include "xil_printf.h"
#include "xgpio.h"
#include "xil_types.h"
#include "sleep.h"

// Get device IDs from xparameters.h
#define LED_ID XPAR_AXI_GPIO_LED_DEVICE_ID
#define JE_ID XPAR_AXI_GPIO_JE_DEVICE_ID
#define LED_CHANNEL 1
#define JE_CHANNEL 1
#define LED_MASK 0b1111
#define JE_MASK 0b11111111

int main() {
	XGpio_Config *cfg_ptr;
	XGpio led_device, je_device;

	xil_printf("Entered function main\r\n");

	cfg_ptr = XGpio_LookupConfig(LED_ID);
	cfg_ptr = XGpio_LookupConfig(JE_ID);

	XGpio_CfgInitialize(&led_device, cfg_ptr, cfg_ptr->BaseAddress);
	XGpio_CfgInitialize(&je_device, cfg_ptr, cfg_ptr->BaseAddress);

	XGpio_SetDataDirection(&led_device, LED_CHANNEL, 0);
	XGpio_SetDataDirection(&je_device, JE_CHANNEL, 0);


	while (1) {
		sleep(1);
		XGpio_DiscreteWrite(&led_device, LED_CHANNEL, 0b1111);
		XGpio_DiscreteWrite(&je_device, JE_CHANNEL, 0b11111111);
		sleep(1);
		XGpio_DiscreteWrite(&led_device, LED_CHANNEL, 0b0000);
		XGpio_DiscreteWrite(&je_device, JE_CHANNEL, 0b00000000);
	}
}

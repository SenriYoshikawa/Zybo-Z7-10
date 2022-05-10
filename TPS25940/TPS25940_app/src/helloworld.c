#include <stdio.h>
#include "platform.h"
#include "xil_printf.h"


int main()
{
    init_platform();

    xil_printf("------XADC register read start------\n");
    for (int i = 0; i < 0x37c; i+=4) {
    	xil_printf("0x%03x : 0x%03x\n", i, *((volatile unsigned int*) (0x43C00000 + i)));
    }
    xil_printf("------Register read end------\n");

    cleanup_platform();
    return 0;
}

#include "headers/vgaprint.h"
/* Hardware text mode color constants. */

void kernel_main(void) 
{
	
	terminal_initialize();
	terminal_setcolor(VGA_COLOR_CYAN);
	terminal_writestring("=:> CAT OS - 'VERSION DUST-1'\n");
	terminal_setcolor(VGA_COLOR_LIGHT_CYAN);
	terminal_writestring("==-=-=-=-=-==-=-==-=-=-=-=-==\n\n");
	terminal_setcolor(VGA_COLOR_CYAN);
	terminal_writestring("=:> Example of string\n");  
}
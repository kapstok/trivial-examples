#include <stdio.h>
#include <string.h>

const char* binary = "1234567890";

int main() {
	printf("The size of the executable is bytes:\n");

	for(int i = 0; i < strlen(binary); i++) {
		if (binary[i] == 0x0) {
			break;
		}

		printf("%c", binary[i]);
	}
}

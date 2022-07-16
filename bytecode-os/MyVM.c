// Compile cmd: gcc MyVM.c -o MyVM
// View vm: ./<filename> | xxd
// View bin files: xxd <filename>

#define NUM_REGS 4
#define BUF_SIZE 17
#include <stdio.h>
#include <stdlib.h>
//#include <fcntl.h> // For file read/write
//#include <unistd.h> // For file close

int regs[NUM_REGS];
ushort prog[] = {0x0000, 0x0000, 0x0000, 0x0000}; //{ 0x1064, 0x11c8, 0x2201, 0x0000 };

int pc = 0;
int fc = 0;
int running = 1;

int fetch() { return prog[pc++]; }

int instruction = 0;
int reg1 = 0;
int reg2 = 0;
int reg3 = 0;
int imm = 0;

void decode (int Instruction) {
	instruction = (Instruction & 0xf000) >> 12;
	reg1 = (Instruction & 0xf00) >> 8;
	reg2 = (Instruction & 0xf0) >> 4;
	reg3 = (Instruction & 0xf);
	imm = (Instruction & 0xff);
}

void eval () {
	switch(instruction) {
		case 0: // instruction = halt
			printf("halt\n");
			running = 0;
			break;
		case 1: // instruction = loadi
			printf("loadi r%d #%d\n", reg1, imm);
			regs[reg1] = imm;
			break;
		case 2: // instruction = add
			printf("add r%d r%d r%d\n", reg1, reg2, reg3);
			regs[reg1] = regs[reg2] + regs[reg3];
			break;
	}
}

void showRegs () {
	int i;
	printf("regs = ");
	for(i = 0; i < NUM_REGS; i++)
		printf("%04x ", regs[i]);
	printf("\n");
}

void run () {
	while(running) {
		showRegs();
		int instruction = fetch();
		decode(instruction);
		eval();
	}
}

void loadBin () {
	char filename[] = { 'p', 'r', 'o', 'g', '.', 'd', 'a', 't' };
	FILE* filedes;
	
	printf("Loading binary..\n");

	filedes = fopen(filename, "rb");

	if(filedes == 0)
		printf("loading failed :(");

	for (int i = 0; i < sizeof(prog) / sizeof(prog[0]); i++) {
		fread(&prog[i], sizeof(ushort), 1, filedes);
		printf("%04x\n", prog[i]);
	}
	fclose(filedes);
	printf("Done!\n");
}

int main (int argc, const char* argv[]) {
	loadBin();
	run();
	return 0;
}

#include <iostream>

#include <unistd.h>
#include <signal.h>

void setHandler(void (*handler)(int,siginfo_t *,void *)) {
	struct sigaction action;
	action.sa_flags = SA_SIGINFO;
	action.sa_sigaction = handler;

	if (sigaction(SIGFPE, &action, NULL) == -1) {
		std::cerr << "sigfpe: sigaction";
		_exit(1);
	}
	if (sigaction(SIGSEGV, &action, NULL) == -1) {
		std::cerr << "sigsegv: sigaction";
		_exit(1);
	}
	if (sigaction(SIGILL, &action, NULL) == -1) {
		std::cerr << "sigill: sigaction";
		_exit(1);
	}
	if (sigaction(SIGBUS, &action, NULL) == -1) {
		std::cerr << "sigbus: sigaction";
		_exit(1);
	}
}

void faultHandler(int signo, siginfo_t* info, void* extra) {
	int i;

	i = ((ucontext_t*)extra)->uc_mcontext.gregs[REG_RIP];	// x86_64
	//i = ((ucontext_t*)extra)->uc_mcontext.arm_pc;		// ARM

	std::cout << "Fout " << (int)signo << " at ";
	std::cout << (int&)info->si_addr << ": " << std::endl;
	std::cout << "Called from " << (int)i << "." << std::endl;

	abort();
}

int main() {
	int* badptr = nullptr;

	setHandler(faultHandler);

	*badptr = 15;

	return 0;
}

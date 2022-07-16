#ifndef _GNU_SOURCE
#define _GNU_SOURCE
#endif

#include <unistd.h>
#include <signal.h>
#include <syslog.h>

#ifdef __cplusplus
	#include <iostream>
	#define ERR(X) std::cerr << X
	#define ABRT() std::abort()
#else
	#include <ucontext.h>
	#include <stdio.h>
	#include <stdlib.h>
	#define ERR(X) perror(X)
	#define ABRT() abort()
#endif

void setHandler(void (*handler)(int,siginfo_t *,void *)) {
	struct sigaction action;
	action.sa_flags = SA_SIGINFO;
	action.sa_sigaction = handler;

	if (sigaction(SIGFPE, &action, NULL) == -1) {
		ERR("sigfpe: sigaction");
		_exit(1);
	}
	if (sigaction(SIGSEGV, &action, NULL) == -1) {
		ERR("sigsegv: sigaction");
		_exit(1);
	}
	if (sigaction(SIGILL, &action, NULL) == -1) {
		ERR("sigill: sigaction");
		_exit(1);
	}
	if (sigaction(SIGBUS, &action, NULL) == -1) {
		ERR("sigbus: sigaction");
		_exit(1);
	}
}

void faultHandler(int signo, siginfo_t* info, void* extra) {
	int i;

	#ifdef __x86_64__
		i = ((ucontext_t*)extra)->uc_mcontext.gregs[REG_RIP];
	#elif __arm__
		i = ((ucontext_t*)extra)->uc_mcontext.arm_pc;
	#else
		#error Compiling for invalid architecture.
	#endif

	openlog("postmortem-debugging", LOG_PERROR | LOG_PID, LOG_LOCAL0);

	syslog(LOG_ERR, "Error %d at %p:\n", signo, info->si_addr);
	syslog(LOG_ERR, "Called from %p.\n", i);
	syslog(LOG_ERR, "Compiled at: %s %s\n", __DATE__, __TIME__);

	closelog();

	ABRT();
}

int main() {
	int* badptr = NULL;

	setHandler(faultHandler);

	*badptr = 15;

	return 0;
}

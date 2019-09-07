#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <signal.h>

// this fixes signal processing for idea
// see https://youtrack.jetbrains.com/issue/IDEA-157989
// signal-reset implemented by Thomas Lee https://github.com/thomaslee/signal-reset
int main (int argc, char **argv) {
    sigset_t sigs;
    struct sigaction sa;

    sigemptyset(&sigs);
    sigaddset(&sigs, SIGINT);
    sigaddset(&sigs, SIGTERM);
    if (sigprocmask(SIG_UNBLOCK, &sigs, 0) != 0) {
        fprintf(stderr, "sigprocmask failed\n");
        return 1;
    }

    memset(&sa, 0, sizeof(sa));
    sa.sa_handler = SIG_DFL;
    if (sigaction(SIGINT, &sa, 0) != 0) {
        fprintf(stderr, "sigaction failed for SIGINT\n");
        return 1;
    }

    memset(&sa, 0, sizeof(sa));
    sa.sa_handler = SIG_DFL;
    if (sigaction(SIGTERM, &sa, 0) != 0) {
        fprintf(stderr, "sigaction failed for SIGTERM\n");
        return 1;
    }

    if (argc <= 1) {
        fprintf(stderr, "usage: %s <command> [args...]\n", argv[0]);
        return 1;
    }

    execvp(argv[1], argv + 1);
    fprintf(stderr, "execvp(...) failed\n");
    return 1;
}

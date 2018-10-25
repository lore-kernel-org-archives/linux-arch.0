From: Enke Chen <enkechen@cisco.com>
Subject: [PATCH] selftests/prctl: selftest for pre-coredump signal
 notification
Date: Thu, 25 Oct 2018 15:56:25 -0700
Message-ID: <24d8585c-e1d8-b363-35e5-5343142c3355@cisco.com>
References: <e7ed306f-8992-9d00-bcab-5131159e8d89@cisco.com>
 <458c04d8-d189-4a26-729a-bb1d1d751534@cisco.com>
 <7741efa7-a3f8-62a1-ba52-613883164643@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7741efa7-a3f8-62a1-ba52-613883164643@cisco.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, "Eric W. Biederman" <ebiederm@xmission.com>, Khalid Aziz <khalid.aziz@oracle.com>, Kate Stewart <kstewart@linuxfoundation.org>, Helge Deller <deller@gmx.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Christian Brauner <christian@brauner.io>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Dave Martin <Dave.Martin@arm.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Michal Hocko <mhocko@kernel.org>, Rik van Riel <riel@s>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, "Victor Kamensky (kamensky)" <kamensky@cisco.com>, xe-linux-external@cisco.com, Stefan Strogin <sstrogin@cisco.com>, Enke Chen <enkechen@cisco.com>
List-Id: linux-arch.vger.kernel.org


Dependency: [PATCH] kernel/signal: Signal-based pre-coredump notification

Signed-off-by: Enke Chen <enkechen@cisco.com>
---
 tools/testing/selftests/prctl/Makefile           |   2 +-
 tools/testing/selftests/prctl/predump-sig-test.c | 160 +++++++++++++++++++++++
 2 files changed, 161 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/prctl/predump-sig-test.c

diff --git a/tools/testing/selftests/prctl/Makefile b/tools/testing/selftests/prctl/Makefile
index c7923b2..f8d60d5 100644
--- a/tools/testing/selftests/prctl/Makefile
+++ b/tools/testing/selftests/prctl/Makefile
@@ -5,7 +5,7 @@ ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
 
 ifeq ($(ARCH),x86)
 TEST_PROGS := disable-tsc-ctxt-sw-stress-test disable-tsc-on-off-stress-test \
-		disable-tsc-test
+		disable-tsc-test predump-sig-test
 all: $(TEST_PROGS)
 
 include ../lib.mk
diff --git a/tools/testing/selftests/prctl/predump-sig-test.c b/tools/testing/selftests/prctl/predump-sig-test.c
new file mode 100644
index 0000000..15d62691
--- /dev/null
+++ b/tools/testing/selftests/prctl/predump-sig-test.c
@@ -0,0 +1,160 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2018, Enke Chen, Cisco Systems, Inc.
+ *
+ * Tests for prctl(PR_SET_PREDUMP_SIG, ...) / prctl(PR_GET_PREDUMP_SIG, ...)
+ *
+ * When set with prctl(), the specified signal is sent to the parent process
+ * prior to the coredump of a child process.
+ *
+ * Usage: ./predump-sig-test {SIGUSR1 | SIGRT2}
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/wait.h>
+#include <sys/prctl.h>
+#include <signal.h>
+#include <errno.h>
+
+#ifndef PR_SET_PREDUMP_SIG
+#define PR_SET_PREDUMP_SIG	54
+#define PR_GET_PREDUMP_SIG	55
+#endif
+
+#define SIGRT2    (SIGRTMIN + 1)
+
+#define handle_error(msg) \
+	do { perror(msg); exit(EXIT_FAILURE); } while (0)
+
+static sig_idx;
+static siginfo_t siginfo_rcv[2];
+
+static void sigaction_func(int sig, siginfo_t *siginfo, void *arg)
+{
+	memcpy(&siginfo_rcv[sig_idx], siginfo, sizeof(siginfo_t));
+	sig_idx++;
+}
+
+static int set_sigaction(int sig)
+{
+	struct sigaction new_action;
+	int rc;
+
+	memset(&new_action, 0, sizeof(struct sigaction));
+	new_action.sa_sigaction = sigaction_func;
+	new_action.sa_flags = SA_SIGINFO;
+	sigemptyset(&new_action.sa_mask);
+
+	return sigaction(sig, &new_action, NULL);
+}
+
+static int test_prctl(int sig)
+{
+	int sig2, rc;
+
+	rc = prctl(PR_SET_PREDUMP_SIG, sig, 0, 0, 0);
+	if (rc < 0)
+		handle_error("prctl: setting");
+
+	rc = prctl(PR_GET_PREDUMP_SIG, &sig2, 0, 0, 0);
+	if (rc < 0)
+		handle_error("prctl: getting");
+
+	if (sig2 != sig) {
+		printf("prctl: sig %d, post %d\n", sig, sig2);
+		return -1;
+	}
+	return 0;
+}
+
+static void child_fn(void)
+{
+	int rc, sig;
+
+	printf("\nChild pid: %ld\n", (long)getpid());
+
+	/* Test: Child should not inherit the predump_signal */
+	rc = prctl(PR_GET_PREDUMP_SIG, &sig, 0, 0, 0);
+	if (rc < 0)
+		handle_error("prctl: child");
+
+	printf("child: predump_signal %d\n", sig);
+
+	/* Force coredump here */
+	printf("child: calling abort()\n");
+	fflush(stdout);
+	abort();
+}
+
+static int parent_fn(pid_t child_pid)
+{
+	int i, status, count;
+	siginfo_t *si;
+	pid_t w;
+
+	for (count = 0; count < 2; count++) {
+		w = waitpid(child_pid, &status, 0);
+		printf("\nwaitpid: %d\n", w);
+		if (w < 0)
+			perror("waitpid");
+
+		si = &siginfo_rcv[count];
+		printf("signal: si_signo %d, si_pid %ld, si_uid %d\n",
+		       si->si_signo, si->si_pid, si->si_uid);
+		printf("siginfo: si_errno %d, si_code %d, si_status %d\n",
+		       si->si_errno, si->si_code, si->si_status);
+	}
+	fflush(stdout);
+}
+
+int main(int argc, char *argv[])
+{
+	pid_t child_pid;
+	int rc, signo;
+
+	if (argc != 2) {
+		printf("invalid number of arguments\n");
+		exit(EXIT_FAILURE);
+	}
+
+	if (strcmp(argv[1], "SIGUSR1") == 0)
+		signo = SIGUSR1;
+	else if (strcmp(argv[1], "SIGRT2") == 0)
+		signo = SIGRT2;
+	else {
+		printf("invalid argument for signal\n");
+		fflush(stdout);
+		exit(EXIT_FAILURE);
+	}
+
+	rc = set_sigaction(SIGCHLD);
+	if (rc < 0)
+		handle_error("set_sigaction: SIGCHLD");
+
+	if (signo != SIGCHLD) {
+		rc = set_sigaction(signo);
+		if (rc < 0)
+			handle_error("set_sigaction: SIGCHLD");
+	}
+
+	/* Test: prctl() setting */
+	rc = test_prctl(0);
+	printf("prctl: sig %d %s\n", 0, (rc == 0) ? "PASS" : "FAIL");
+
+	rc = test_prctl(signo);
+	printf("prctl: sig %d %s\n", signo, (rc == 0) ? "PASS" : "FAIL");
+
+	child_pid = fork();
+	if (child_pid == -1)
+		handle_error("fork");
+
+	if (child_pid == 0) {       /* Code executed by child */
+		child_fn();
+	} else {                    /* Code executed by parent */
+		parent_fn(child_pid);
+		exit(EXIT_SUCCESS);
+	}
+}
-- 
1.8.3.1

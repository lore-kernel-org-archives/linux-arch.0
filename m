Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794575957;
	b=4qCTUBqJ+6P6VJBN4yNiPNi661/0276RDHfRcAv/1fabw5NDxmeVpteZvwWKF7oT/1S/
	 8h6sg4F0sy3BHjyhKGtZNRWikjkOBIBf+N3WYUoBmtaEVKnJU5isWlmqyUoGlJaPewU6b
	 fbVfmy2BXFtvCaG4kv7QieNNSkau2vgcm8bEXnbfQ3s+1x2OCGxcGRYz97/gzr+kajBN2
	 WhslF6PkpR8oSqt34kOk2fOBNiuLNfVOxXCJCPX+dqbZtZuwv5m+qNnlNTKu7bAfEvn5H
	 AtSQZL9zha9lxefRYs224cORu06RgyQy5WFg0M7lxvNf7RZ33J718er1K6IE0TmUzMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794575957;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=B+Kv6NWvYAW9LgU4w/PYUOqJKuqBS7y3QSlmC0jmQEE=;
	b=dbsatPuN199F94Wg+sNmrcSJKNt04TbNyn47LcLLn0o0l8E+rGCwdtT77ie7d2zk6qtQ
	 Q1vvweD1kjf7y6p+WLH1IBkILQSZrzPY1wNmpRkDqaG5cUqvagk416RC/GYIY3Fmxym3h
	 /07KxNQdJce/9FWOCe3y0s1fiWZS+JihOa96gWsunhlq835+H1lvTkyR6rfCvwc2xD8eU
	 CQ8x67wdiaKtzap7pdIwbuvIzOu1RSdr0q4DOAIIMmGISUD8kfdWG1W9UiCeWVoUN9ceT
	 4tqvcaVJCNkDV/2x5ve0dpCGzWk+dOaTZZqYyRoA2NyCZcsh3T8V9CwFVVb/ztlf0qg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=uzdwVrmO;
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F7C606A890;
	Fri, 13 Nov 2026 13:19:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79F7C606A890
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=uzdwVrmO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1794575950;
	bh=B+Kv6NWvYAW9LgU4w/PYUOqJKuqBS7y3QSlmC0jmQEE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uzdwVrmOPenZL8yin/nLlzevFb/tM/owH8nip1lmaXLk0ouFbH4w2k8bLOofqqiTX
	 Qs3VNLET6vNzA/UE5DGgXT9AEaKiY/bqEjl8Nn2w8shovyJp1VQrWNphP9qS24EqvT
	 AjcOCXBcrol2mwzPfRBdiHeC37U986a/nF01YcyfPmEubMcGKu6coZhooVZnR9LUtp
	 HSb1hLafn3fKxP9KPWRNrvAvgh/GM4zzBKhHMjyy0Ld5Hk9MIKgs++1jBeWl8WhHx2
	 ypKkFLXpbhxTaXvJ+uShyPBo9CpbB7Wx+1DYaEK/OrigCU2Oc7Xdg3zxxs9Q3n32rD
	 F7wlZcW8MC61A==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jQyWx6qN6zPmY;
	Fri, 13 Nov 2026 08:19:09 -0500 (EST)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Michal Clapinski <mclapinski@google.com>,
	Andrei Vagin <avagin@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Aniket Gattani <aniketgattani@google.com>,
	linux-kselftest@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Gellermann <christian.gellermann@codasip.com>,
	Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>,
	Wei Yang <richard.weiyang@gmail.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	loongarch@lists.linux.dev,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Helge Deller <deller@gmx.de>,
	John David Anglin <dave.anglin@bell.net>,
	linux-parisc@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Guo Ren <guoren@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-csky@vger.kernel.org,
	Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Stafford Horne <shorne@gmail.com>,
	linux-openrisc@vger.kernel.org,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	linux-sh@vger.kernel.org,
	Chris Zankel <chris@zankel.net>,
	Max Filippov <jcmvbkbc@gmail.com>,
	linux-arch@vger.kernel.org,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	Andy Lutomirski <luto@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Andrea Parri <parri.andrea@gmail.com>,
	Boqun Feng <boqun@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	David Howells <dhowells@redhat.com>,
	Jade Alglave <j.alglave@ucl.ac.uk>,
	Luc Maranget <luc.maranget@inria.fr>,
	Akira Yokosawa <akiyks@gmail.com>,
	Daniel Lustig <dlustig@nvidia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	lkmm@lists.linux.dev,
	bpf@vger.kernel.org,
	Naveen N Rao <naveen@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org
Subject: [RFC PATCH 06/16] selftests/membarrier: Test which CPUs the expedited commands interrupt
Date: Fri, 13 Nov 2026 08:18:53 -0500
Message-Id: <20261113131903.157186-7-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261113131903.157186-1-mathieu.desnoyers@efficios.com>
References: <20261113131903.157186-1-mathieu.desnoyers@efficios.com>
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The existing tests only check the return value of each command. They
cannot tell whether a command reached the threads it must reach.

Add membarrier_test_ipi. A test cannot observe a missing memory
barrier reliably. It can observe a missing IPI in /proc/interrupts.
The comment at the top of the file describes the method. The test
cases are:

 - global expedited reaches a registered process and skips an
   unregistered one,
 - global expedited reaches a registered process after one of its
   threads exits,
 - global expedited reaches a process which registered on another CPU
   and came back to a CPU which stayed idle meanwhile,
 - global expedited reaches each thread of a process which registered
   while multi-threaded,
 - global expedited reaches a forked child and skips a process after
   exec,
 - private expedited, sync core and rseq reach each thread,
 - rseq with MEMBARRIER_CMD_FLAG_CPU reaches only the CPU it names,
 - private expedited skips another registered process,
 - private expedited reaches a CLONE_VM task of another thread group.

Each test case runs in its own process, because a membarrier
registration cannot be undone.

The thread exit and idle CPU cases fail without commit
"sched/membarrier: Fix stale runqueue state after a lazy mm switch".

The test is skipped with fewer than 3 allowed CPUs. It is also skipped
when /proc/interrupts has no function call interrupt count.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 tools/testing/selftests/membarrier/.gitignore |   1 +
 tools/testing/selftests/membarrier/Makefile   |   1 +
 .../membarrier/membarrier_test_ipi.c          | 739 ++++++++++++++++++
 3 files changed, 741 insertions(+)
 create mode 100644 tools/testing/selftests/membarrier/membarrier_test_ipi.c

diff --git a/tools/testing/selftests/membarrier/.gitignore b/tools/testing/selftests/membarrier/.gitignore
index 031920478205..58969a5e4613 100644
--- a/tools/testing/selftests/membarrier/.gitignore
+++ b/tools/testing/selftests/membarrier/.gitignore
@@ -2,3 +2,4 @@
 membarrier_test_multi_thread
 membarrier_test_single_thread
 membarrier_rseq_stress
+membarrier_test_ipi
diff --git a/tools/testing/selftests/membarrier/Makefile b/tools/testing/selftests/membarrier/Makefile
index 20bb66380090..ee5b9deb808b 100644
--- a/tools/testing/selftests/membarrier/Makefile
+++ b/tools/testing/selftests/membarrier/Makefile
@@ -4,6 +4,7 @@ LDLIBS += -lpthread
 
 TEST_GEN_PROGS := membarrier_test_single_thread \
 		membarrier_test_multi_thread \
+		membarrier_test_ipi \
 		membarrier_rseq_stress
 
 LOCAL_HDRS += membarrier_test_impl.h
diff --git a/tools/testing/selftests/membarrier/membarrier_test_ipi.c b/tools/testing/selftests/membarrier/membarrier_test_ipi.c
new file mode 100644
index 000000000000..49b74844c1f4
--- /dev/null
+++ b/tools/testing/selftests/membarrier/membarrier_test_ipi.c
@@ -0,0 +1,739 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Check which CPUs the expedited membarrier commands interrupt.
+ *
+ * An expedited command sends an IPI to each CPU which runs a targeted
+ * thread. The IPI is the memory barrier. A test cannot observe a
+ * missing memory barrier reliably. It can observe a missing IPI: the
+ * kernel counts the function call interrupts of each CPU in
+ * /proc/interrupts.
+ *
+ * Each test case pins a "target" which spins in user-space on its own
+ * CPU. A "sender" pinned on another CPU issues the command NR_CMDS
+ * times. The test then compares the count of function call interrupts
+ * of the target CPU before and after.
+ *
+ * Each test case runs in its own process because a membarrier
+ * registration cannot be undone.
+ */
+#define _GNU_SOURCE
+#include <linux/membarrier.h>
+#include <sys/mman.h>
+#include <sys/prctl.h>
+#include <sys/wait.h>
+#include <syscall.h>
+#include <stdatomic.h>
+#include <pthread.h>
+#include <signal.h>
+#include <stdbool.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <sched.h>
+#include <stdio.h>
+#include <errno.h>
+#include <time.h>
+
+#include "kselftest.h"
+
+#define NR_CMDS		1000
+/*
+ * A target which must be interrupted can lose a few IPIs when another
+ * task preempts it. A target which must not be interrupted can receive
+ * a few unrelated IPIs. The observed counts are either close to
+ * NR_CMDS or close to zero. Keep a wide margin on both sides.
+ */
+#define MIN_HIT		(NR_CMDS / 2)
+#define MAX_MISS	(NR_CMDS / 4)
+
+#define MAX_TARGETS	2
+/* Seconds to wait for the targets of a test case. */
+#define READY_TIMEOUT	10
+#define STACK_SIZE	(64 * 1024)
+
+/*
+ * Exit status of a test case process. Each skip status has its own
+ * reason, which run_case() reports. CASE_FAIL is a failure of
+ * membarrier. CASE_ERROR is a failure of the test setup.
+ */
+enum {
+	CASE_PASS = 0,
+	CASE_FAIL = 1,
+	CASE_SKIP_NO_COUNT = 2,
+	CASE_SKIP_NO_CMD = 3,
+	CASE_ERROR = 4,
+};
+
+struct shared {
+	atomic_int ready;
+	atomic_int stop;
+};
+
+static struct shared *shared;
+static int shared_fd;
+
+/* CPU of the sender and CPUs of the targets. */
+static int sender_cpu, target_cpu[MAX_TARGETS];
+
+static int sys_membarrier(int cmd, unsigned int flags, int cpu_id)
+{
+	return syscall(__NR_membarrier, cmd, flags, cpu_id);
+}
+
+/* Pin the task @pid on @cpu. A @pid of 0 is the calling thread. */
+static void pin_task(pid_t pid, int cpu)
+{
+	cpu_set_t set;
+
+	CPU_ZERO(&set);
+	CPU_SET(cpu, &set);
+	if (sched_setaffinity(pid, sizeof(set), &set)) {
+		perror("sched_setaffinity");
+		_exit(CASE_ERROR);
+	}
+}
+
+static void pin_to_cpu(int cpu)
+{
+	pin_task(0, cpu);
+}
+
+/* Die with the parent. A killed test must leave no spinning target. */
+static void die_with_parent(void)
+{
+	if (prctl(PR_SET_PDEATHSIG, SIGKILL)) {
+		perror("prctl");
+		_exit(CASE_ERROR);
+	}
+}
+
+static void must_join(pthread_t thread)
+{
+	errno = pthread_join(thread, NULL);
+	if (errno) {
+		perror("pthread_join");
+		_exit(CASE_ERROR);
+	}
+}
+
+/* Wait for the child @pid. Its setup failed unless it exits with 0. */
+static void must_wait(pid_t pid)
+{
+	int status;
+
+	if (waitpid(pid, &status, 0) != pid) {
+		perror("waitpid");
+		_exit(CASE_ERROR);
+	}
+	if (!WIFEXITED(status) || WEXITSTATUS(status)) {
+		fprintf(stderr, "# child %d did not exit with 0\n", pid);
+		_exit(CASE_ERROR);
+	}
+}
+
+static void must_register(int cmd)
+{
+	if (sys_membarrier(cmd, 0, 0)) {
+		perror("membarrier registration");
+		_exit(CASE_ERROR);
+	}
+}
+
+/* Announce that this target is in place, then spin in user-space. */
+static void spin(void)
+{
+	die_with_parent();
+	atomic_fetch_add(&shared->ready, 1);
+	while (!atomic_load(&shared->stop))
+		;
+}
+
+/*
+ * Wait until @nr targets spin. Report a setup error when they do not
+ * show up: a target may have died in its setup.
+ */
+static void wait_ready(int nr)
+{
+	time_t start = time(NULL);
+
+	while (atomic_load(&shared->ready) < nr) {
+		if (time(NULL) - start > READY_TIMEOUT) {
+			fprintf(stderr, "# the targets are not ready\n");
+			atomic_store(&shared->stop, 1);
+			_exit(CASE_ERROR);
+		}
+		sched_yield();
+	}
+}
+
+/*
+ * Read the count of function call interrupts of each CPU of @cpus.
+ * Return false when /proc/interrupts has no such count for one of
+ * them. An offline CPU has no count.
+ */
+static bool read_ipi_counts(const int *cpus, int nr_cpus, long *counts)
+{
+	int *col_cpu = NULL, nr_cols = 0, i, c;
+	char *line = NULL, *p, *end;
+	unsigned int seen = 0;
+	size_t len = 0;
+	FILE *f;
+
+	for (c = 0; c < nr_cpus; c++)
+		counts[c] = 0;
+	f = fopen("/proc/interrupts", "r");
+	if (!f)
+		return false;
+	/* The first line names the CPU of each column. */
+	if (getline(&line, &len, f) < 0)
+		goto out;
+	for (p = line; (p = strstr(p, "CPU")); p = end) {
+		int cpu = strtol(p + 3, &end, 10);
+
+		int *new_col_cpu;
+
+		new_col_cpu = realloc(col_cpu, (nr_cols + 1) * sizeof(*col_cpu));
+		if (!new_col_cpu)
+			goto out;
+		col_cpu = new_col_cpu;
+		col_cpu[nr_cols++] = cpu;
+	}
+	while (getline(&line, &len, f) >= 0) {
+		/* x86 uses the "CAL" label. Others describe the line. */
+		if (!strstr(line, "CAL:") && !strstr(line, "unction call"))
+			continue;
+		p = strchr(line, ':');
+		if (!p)
+			continue;
+		p++;
+		for (i = 0; i < nr_cols; i++) {
+			long val = strtol(p, &end, 10);
+
+			if (end == p)
+				break;
+			p = end;
+			for (c = 0; c < nr_cpus; c++)
+				if (cpus[c] == col_cpu[i]) {
+					counts[c] += val;
+					seen |= 1U << c;
+				}
+		}
+	}
+out:
+	free(col_cpu);
+	free(line);
+	fclose(f);
+	return seen == (1U << nr_cpus) - 1;
+}
+
+/*
+ * Issue @cmd NR_CMDS times. Store into @delta the count of function
+ * call interrupts which each target CPU received meanwhile.
+ */
+static int send_cmds(int cmd, unsigned int flags, int cpu_id, long *delta)
+{
+	long before[MAX_TARGETS], after[MAX_TARGETS];
+	int i;
+
+	if (!read_ipi_counts(target_cpu, MAX_TARGETS, before))
+		return CASE_SKIP_NO_COUNT;
+	for (i = 0; i < NR_CMDS; i++) {
+		if (sys_membarrier(cmd, flags, cpu_id)) {
+			perror("membarrier");
+			return CASE_FAIL;
+		}
+	}
+	if (!read_ipi_counts(target_cpu, MAX_TARGETS, after))
+		return CASE_SKIP_NO_COUNT;
+	for (i = 0; i < MAX_TARGETS; i++)
+		delta[i] = after[i] - before[i];
+	return CASE_PASS;
+}
+
+static int expect_hit(int target, long *delta)
+{
+	if (delta[target] >= MIN_HIT)
+		return CASE_PASS;
+	fprintf(stderr, "# CPU %d received %ld IPIs for %d commands\n",
+		target_cpu[target], delta[target], NR_CMDS);
+	return CASE_FAIL;
+}
+
+static int expect_miss(int target, long *delta)
+{
+	if (delta[target] <= MAX_MISS)
+		return CASE_PASS;
+	fprintf(stderr, "# CPU %d received %ld IPIs, expected none\n",
+		target_cpu[target], delta[target]);
+	return CASE_FAIL;
+}
+
+/*
+ * Global expedited test cases.
+ *
+ * The sender is the test case process. The target is a child process.
+ * @setup runs in the child and ends with spin().
+ */
+
+static void *thread_nop(void *arg)
+{
+	return NULL;
+}
+
+static void *thread_spin(void *arg)
+{
+	pin_to_cpu(target_cpu[(long)arg]);
+	spin();
+	return NULL;
+}
+
+static void setup_registered(void)
+{
+	must_register(MEMBARRIER_CMD_REGISTER_GLOBAL_EXPEDITED);
+	spin();
+}
+
+static void setup_unregistered(void)
+{
+	spin();
+}
+
+/*
+ * The exiting thread clears the runqueue membarrier state in
+ * exit_mm(). The scheduler then switches to the main thread, which
+ * has the same mm.
+ */
+static void setup_thread_exit(void)
+{
+	pthread_t thread;
+
+	must_register(MEMBARRIER_CMD_REGISTER_GLOBAL_EXPEDITED);
+	if (pthread_create(&thread, NULL, thread_nop, NULL))
+		_exit(CASE_ERROR);
+	must_join(thread);
+	spin();
+}
+
+/*
+ * Register on another CPU. Meanwhile the first CPU is idle and its
+ * idle thread borrows the mm of this process. Come back to the first
+ * CPU: the scheduler switches from the idle thread to this process.
+ */
+static void setup_lazy_tlb(void)
+{
+	pin_to_cpu(target_cpu[1]);
+	must_register(MEMBARRIER_CMD_REGISTER_GLOBAL_EXPEDITED);
+	pin_to_cpu(target_cpu[0]);
+	spin();
+}
+
+/* Register from a multi-threaded process. Both threads are targets. */
+static void setup_multi_thread(void)
+{
+	pthread_t thread;
+
+	if (pthread_create(&thread, NULL, thread_spin, (void *)1L))
+		_exit(CASE_ERROR);
+	wait_ready(1);
+	must_register(MEMBARRIER_CMD_REGISTER_GLOBAL_EXPEDITED);
+	spin();
+}
+
+/* A forked child inherits the registration. */
+static void setup_fork(void)
+{
+	pid_t pid;
+
+	must_register(MEMBARRIER_CMD_REGISTER_GLOBAL_EXPEDITED);
+	pid = fork();
+	if (pid < 0)
+		_exit(CASE_ERROR);
+	if (!pid) {
+		spin();
+		_exit(0);
+	}
+	must_wait(pid);
+}
+
+/* exec() drops the registration. */
+static void setup_exec(void)
+{
+	char fd_str[16];
+
+	must_register(MEMBARRIER_CMD_REGISTER_GLOBAL_EXPEDITED);
+	snprintf(fd_str, sizeof(fd_str), "%d", shared_fd);
+	execl("/proc/self/exe", "membarrier_test_ipi", "--spin", fd_str, NULL);
+	perror("execl");
+	_exit(CASE_ERROR);
+}
+
+static int test_global(void (*setup)(void), int nr_targets, bool hit)
+{
+	long delta[MAX_TARGETS];
+	int ret, i;
+	pid_t pid;
+
+	if (!(sys_membarrier(MEMBARRIER_CMD_QUERY, 0, 0) &
+	      MEMBARRIER_CMD_GLOBAL_EXPEDITED))
+		return CASE_SKIP_NO_CMD;
+	pid = fork();
+	if (pid < 0)
+		return CASE_ERROR;
+	if (!pid) {
+		die_with_parent();
+		pin_to_cpu(target_cpu[0]);
+		setup();
+		_exit(0);
+	}
+	wait_ready(nr_targets);
+	ret = send_cmds(MEMBARRIER_CMD_GLOBAL_EXPEDITED, 0, 0, delta);
+	atomic_store(&shared->stop, 1);
+	must_wait(pid);
+	for (i = 0; !ret && i < nr_targets; i++)
+		ret = hit ? expect_hit(i, delta) : expect_miss(i, delta);
+	return ret;
+}
+
+static int case_global_registered(void)
+{
+	return test_global(setup_registered, 1, true);
+}
+
+static int case_global_unregistered(void)
+{
+	return test_global(setup_unregistered, 1, false);
+}
+
+static int case_global_thread_exit(void)
+{
+	return test_global(setup_thread_exit, 1, true);
+}
+
+static int case_global_lazy_tlb(void)
+{
+	return test_global(setup_lazy_tlb, 1, true);
+}
+
+static int case_global_multi_thread(void)
+{
+	return test_global(setup_multi_thread, 2, true);
+}
+
+static int case_global_fork(void)
+{
+	return test_global(setup_fork, 1, true);
+}
+
+static int case_global_exec(void)
+{
+	return test_global(setup_exec, 1, false);
+}
+
+/*
+ * Private expedited test cases.
+ *
+ * The sender is the main thread of the test case process. The targets
+ * are threads of the same process, one per target CPU.
+ */
+
+static int start_thread_targets(pthread_t *threads)
+{
+	long i;
+
+	for (i = 0; i < MAX_TARGETS; i++)
+		if (pthread_create(&threads[i], NULL, thread_spin, (void *)i))
+			return CASE_ERROR;
+	wait_ready(MAX_TARGETS);
+	return CASE_PASS;
+}
+
+static void stop_thread_targets(pthread_t *threads)
+{
+	int i;
+
+	atomic_store(&shared->stop, 1);
+	for (i = 0; i < MAX_TARGETS; i++)
+		must_join(threads[i]);
+}
+
+static int test_private(int register_cmd, int cmd)
+{
+	pthread_t threads[MAX_TARGETS];
+	long delta[MAX_TARGETS];
+	int ret, i;
+
+	if (!(sys_membarrier(MEMBARRIER_CMD_QUERY, 0, 0) & cmd))
+		return CASE_SKIP_NO_CMD;
+	if (start_thread_targets(threads))
+		return CASE_ERROR;
+	must_register(register_cmd);
+	ret = send_cmds(cmd, 0, 0, delta);
+	stop_thread_targets(threads);
+	for (i = 0; !ret && i < MAX_TARGETS; i++)
+		ret = expect_hit(i, delta);
+	return ret;
+}
+
+static int case_private(void)
+{
+	return test_private(MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED,
+			    MEMBARRIER_CMD_PRIVATE_EXPEDITED);
+}
+
+static int case_private_sync_core(void)
+{
+	return test_private(MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_SYNC_CORE,
+			    MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE);
+}
+
+static int case_private_rseq(void)
+{
+	return test_private(MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_RSEQ,
+			    MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ);
+}
+
+/* MEMBARRIER_CMD_FLAG_CPU interrupts only the CPU it names. */
+static int case_private_rseq_cpu(void)
+{
+	pthread_t threads[MAX_TARGETS];
+	long delta[MAX_TARGETS];
+	int ret;
+
+	if (!(sys_membarrier(MEMBARRIER_CMD_QUERY, 0, 0) &
+	      MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ))
+		return CASE_SKIP_NO_CMD;
+	if (start_thread_targets(threads))
+		return CASE_ERROR;
+	must_register(MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_RSEQ);
+	ret = send_cmds(MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ,
+			MEMBARRIER_CMD_FLAG_CPU, target_cpu[0], delta);
+	stop_thread_targets(threads);
+	if (!ret)
+		ret = expect_hit(0, delta);
+	if (!ret)
+		ret = expect_miss(1, delta);
+	return ret;
+}
+
+/* A private command does not interrupt another registered process. */
+static int case_private_other_process(void)
+{
+	long delta[MAX_TARGETS];
+	pthread_t thread;
+	pid_t pid;
+	int ret;
+
+	if (!(sys_membarrier(MEMBARRIER_CMD_QUERY, 0, 0) &
+	      MEMBARRIER_CMD_PRIVATE_EXPEDITED))
+		return CASE_SKIP_NO_CMD;
+	pid = fork();
+	if (pid < 0)
+		return CASE_ERROR;
+	if (!pid) {
+		pin_to_cpu(target_cpu[0]);
+		must_register(MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED);
+		spin();
+		_exit(0);
+	}
+	if (pthread_create(&thread, NULL, thread_spin, (void *)1L))
+		return CASE_ERROR;
+	wait_ready(2);
+	must_register(MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED);
+	ret = send_cmds(MEMBARRIER_CMD_PRIVATE_EXPEDITED, 0, 0, delta);
+	atomic_store(&shared->stop, 1);
+	must_join(thread);
+	must_wait(pid);
+	if (!ret)
+		ret = expect_miss(0, delta);
+	if (!ret)
+		ret = expect_hit(1, delta);
+	return ret;
+}
+
+/*
+ * This task shares the TLS of its parent. Its parent pins it, so that
+ * it only spins.
+ */
+static int clone_vm_fn(void *arg)
+{
+	spin();
+	return 0;
+}
+
+/*
+ * A private command covers every task which uses the mm. This includes
+ * a task of another thread group created with CLONE_VM.
+ */
+static int case_private_clone_vm(void)
+{
+	long delta[MAX_TARGETS];
+	char *stack;
+	pid_t pid;
+	int ret;
+
+	if (!(sys_membarrier(MEMBARRIER_CMD_QUERY, 0, 0) &
+	      MEMBARRIER_CMD_PRIVATE_EXPEDITED))
+		return CASE_SKIP_NO_CMD;
+	stack = malloc(STACK_SIZE);
+	if (!stack)
+		return CASE_ERROR;
+	pid = clone(clone_vm_fn, stack + STACK_SIZE, CLONE_VM | SIGCHLD, NULL);
+	if (pid < 0) {
+		free(stack);
+		return CASE_ERROR;
+	}
+	pin_task(pid, target_cpu[0]);
+	wait_ready(1);
+	must_register(MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED);
+	ret = send_cmds(MEMBARRIER_CMD_PRIVATE_EXPEDITED, 0, 0, delta);
+	atomic_store(&shared->stop, 1);
+	must_wait(pid);
+	free(stack);
+	if (!ret)
+		ret = expect_hit(0, delta);
+	return ret;
+}
+
+static const struct test_case {
+	const char *name;
+	int (*fn)(void);
+} test_cases[] = {
+	{ "global expedited reaches a registered process",
+	  case_global_registered },
+	{ "global expedited skips an unregistered process",
+	  case_global_unregistered },
+	{ "global expedited reaches a process after a thread exit",
+	  case_global_thread_exit },
+	{ "global expedited reaches a process registered on another CPU",
+	  case_global_lazy_tlb },
+	{ "global expedited reaches each thread of a process",
+	  case_global_multi_thread },
+	{ "global expedited reaches a forked child",
+	  case_global_fork },
+	{ "global expedited skips a process after exec",
+	  case_global_exec },
+	{ "private expedited reaches each thread",
+	  case_private },
+	{ "private expedited sync core reaches each thread",
+	  case_private_sync_core },
+	{ "private expedited rseq reaches each thread",
+	  case_private_rseq },
+	{ "private expedited rseq with a CPU reaches only that CPU",
+	  case_private_rseq_cpu },
+	{ "private expedited skips another process",
+	  case_private_other_process },
+	{ "private expedited reaches a CLONE_VM task",
+	  case_private_clone_vm },
+};
+
+static void run_case(const struct test_case *tc)
+{
+	int status;
+	pid_t pid;
+
+	atomic_store(&shared->ready, 0);
+	atomic_store(&shared->stop, 0);
+	pid = fork();
+	if (pid < 0)
+		ksft_exit_fail_msg("fork failed\n");
+	if (!pid) {
+		/* The targets inherit this process group. */
+		if (setpgid(0, 0)) {
+			perror("setpgid");
+			_exit(CASE_ERROR);
+		}
+		die_with_parent();
+		pin_to_cpu(sender_cpu);
+		_exit(tc->fn());
+	}
+	if (waitpid(pid, &status, 0) != pid)
+		ksft_exit_fail_msg("waitpid failed\n");
+	/*
+	 * Kill the targets which a failed test case left behind. There
+	 * is usually none: kill() then fails with ESRCH.
+	 */
+	atomic_store(&shared->stop, 1);
+	if (kill(-pid, SIGKILL) && errno != ESRCH)
+		ksft_exit_fail_msg("kill failed\n");
+	if (!WIFEXITED(status))
+		status = CASE_FAIL;
+	else
+		status = WEXITSTATUS(status);
+	switch (status) {
+	case CASE_PASS:
+		ksft_test_result_pass("%s\n", tc->name);
+		break;
+	case CASE_SKIP_NO_COUNT:
+		ksft_test_result_skip("%s: Cannot read the interrupt counts\n",
+				      tc->name);
+		break;
+	case CASE_SKIP_NO_CMD:
+		ksft_test_result_skip("%s: Command not available\n",
+				      tc->name);
+		break;
+	case CASE_ERROR:
+		ksft_test_result_error("%s: Test setup failed\n", tc->name);
+		break;
+	default:
+		ksft_test_result_fail("%s\n", tc->name);
+	}
+}
+
+/* Pick the sender CPU and the target CPUs among the allowed CPUs. */
+static bool pick_cpus(void)
+{
+	int cpu, nr = 0, *dst[] = {
+		&sender_cpu, &target_cpu[0], &target_cpu[1],
+	};
+	cpu_set_t set;
+
+	if (sched_getaffinity(0, sizeof(set), &set))
+		return false;
+	for (cpu = 0; cpu < CPU_SETSIZE && nr < ARRAY_SIZE(dst); cpu++)
+		if (CPU_ISSET(cpu, &set))
+			*dst[nr++] = cpu;
+	return nr == ARRAY_SIZE(dst);
+}
+
+static struct shared *map_shared(int fd)
+{
+	void *p;
+
+	p = mmap(NULL, sizeof(struct shared), PROT_READ | PROT_WRITE,
+		 MAP_SHARED, fd, 0);
+	return p == MAP_FAILED ? NULL : p;
+}
+
+int main(int argc, char **argv)
+{
+	long counts[MAX_TARGETS];
+	int i;
+
+	/* Target of the exec test case. See setup_exec(). */
+	if (argc == 3 && !strcmp(argv[1], "--spin")) {
+		shared = map_shared(atoi(argv[2]));
+		if (!shared)
+			return CASE_ERROR;
+		spin();
+		return 0;
+	}
+
+	ksft_print_header();
+	if (sys_membarrier(MEMBARRIER_CMD_QUERY, 0, 0) < 0)
+		ksft_exit_skip("sys membarrier (CONFIG_MEMBARRIER) is disabled.\n");
+	if (!pick_cpus())
+		ksft_exit_skip("This test needs 3 allowed CPUs.\n");
+	if (!read_ipi_counts(target_cpu, MAX_TARGETS, counts))
+		ksft_exit_skip("No function call interrupt count in /proc/interrupts.\n");
+	shared_fd = memfd_create("membarrier_test_ipi", 0);
+	if (shared_fd < 0 || ftruncate(shared_fd, sizeof(struct shared)))
+		ksft_exit_fail_msg("memfd_create failed\n");
+	shared = map_shared(shared_fd);
+	if (!shared)
+		ksft_exit_fail_msg("mmap failed\n");
+
+	ksft_set_plan(ARRAY_SIZE(test_cases));
+	for (i = 0; i < ARRAY_SIZE(test_cases); i++)
+		run_case(&test_cases[i]);
+	ksft_finished();
+}
-- 
2.47.3


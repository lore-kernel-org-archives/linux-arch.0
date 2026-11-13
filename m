Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794575957;
	b=BTYGZ8ylT7wh6V5N8RtVO7LnUl1TvI0gne1E4JOWDGKcE/iLH+MLA2+FDu54me1fpnvA
	 G/smcVtNS0vc4p8qhW7+3SDvDYC0gA3DF1l5jG/IwfFgoC30CTHqVusjGagkZOBQubDQ2
	 pNXBB12qgehRzvhdd16dtNwsrcT4KV/z/dBqIyctZ1WR/jTCzKiBuRoHYzqbU2nfHOebc
	 8/7UD9ZyBAo63wbXac/YHPJRSdvj3TKbPKDDzicOZwI9rlyCoKkQb47X9TC76vDGLOmG+
	 IRLh2wPej9i7X7UCCLXyZLf6i350lSOVH2KrWZ3ywEKKaaS7elFPBh+fwPHpNjQ8IYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794575957;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=8OhAk9cmyRbLG0MiVOEFk9DU+w4LVEx3Semv5sjBMcE=;
	b=c52z4rwpcb8bgYTFSzDCswTftW6nq46SRnP6naB/EbUBkimVpHOSoTQ/fiww3ujmk/5v
	 KqxSEfq+PclfHZ2XaOF3NVtXx5dF2En9IM105NGoSY1GC7J76v/iRjeTBABLxfrV6oyMa
	 ncb+s0jweyp46m8KazLq7JhPuw0A+Kj3rBkSBk1etX3SfzTAsoy6hwe6GF7afmYcEMqlT
	 XRqccZ6mw/3qDTUwGEPqcsnfm+myxj1KCggWWCh3dvG6Cn7ETQ7IMOtCObioQ/YFD8DXU
	 lfDSUbIxZnN03PaRknSNBsW8M4IvJC0WYN9KXjM5StebEyDRE2hygXiDpAgRovegvHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b="gB8/n3oE";
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FA9606A89C;
	Fri, 13 Nov 2026 13:19:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79FA9606A89C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=gB8/n3oE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1794575950;
	bh=8OhAk9cmyRbLG0MiVOEFk9DU+w4LVEx3Semv5sjBMcE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gB8/n3oEPTSMcNN9PdI9lIveWGuLnluQZil7NIeWFqwYI4Gw9gjeUngDIWVZTwpwC
	 ev3GqxrZUFItO0Z0bdp4UkWTvgelfNPzCaxqyE6pAewOLcEliu8TAyGFUC3EgF/AXr
	 KX/PzKmMk/F7ajfdA+aWSN93ZjFNgVMTnGepMcGhHONnwzz0cyGm9TrUfV7H5P9FAr
	 G+vZJSJdtYc0QCH46I7hpJmr/ePCojt3tr2uWshOjLr3BbHKsiHgy+q0XIbxxasEvd
	 gtmY52BTLXh/fTROKqSk6K/fEKOGyrr0+jhhUbQe4+OqBHorjefk8dtWhhwGOMsYiw
	 Rs8opj+Gsilsg==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jQyWy1b9lzPX1;
	Fri, 13 Nov 2026 08:19:10 -0500 (EST)
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
Subject: [RFC PATCH 07/16] selftests/membarrier: Test command arguments and registration lifetime
Date: Fri, 13 Nov 2026 08:18:54 -0500
Message-Id: <20261113131903.157186-8-mathieu.desnoyers@efficios.com>
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

The existing tests issue each command once with valid arguments, in
one fixed order of registrations. They miss the following:

 - the query mask is not compared with the commands which the kernel
   accepts. Commit 809232619f5b ("sched/membarrier: Fix
   membarrier-rseq fence command missing from query bitmask") fixed
   such a mismatch,
 - only MEMBARRIER_CMD_QUERY is tested with an invalid flag,
 - only the stress test issues the rseq command. Its registration,
   its -EPERM result and its CPU argument are not checked,
 - each registration is not tested alone. Commit fc0d77387cb5
   ("sched/membarrier: Fix private expedited registration check")
   fixed an interaction between two registrations,
 - the registrations are not tested across fork, exec and CLONE_VM.

Add membarrier_test_cmd for those. It uses the kselftest harness,
which runs each test in its own process. A registration cannot be
undone, so each test needs a new process.

The sync core and rseq registration tests fail without commit
"sched/membarrier: Report only completed registrations".

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 tools/testing/selftests/membarrier/.gitignore |   1 +
 tools/testing/selftests/membarrier/Makefile   |   1 +
 .../membarrier/membarrier_test_cmd.c          | 352 ++++++++++++++++++
 3 files changed, 354 insertions(+)
 create mode 100644 tools/testing/selftests/membarrier/membarrier_test_cmd.c

diff --git a/tools/testing/selftests/membarrier/.gitignore b/tools/testing/selftests/membarrier/.gitignore
index 58969a5e4613..45b995b884a6 100644
--- a/tools/testing/selftests/membarrier/.gitignore
+++ b/tools/testing/selftests/membarrier/.gitignore
@@ -3,3 +3,4 @@ membarrier_test_multi_thread
 membarrier_test_single_thread
 membarrier_rseq_stress
 membarrier_test_ipi
+membarrier_test_cmd
diff --git a/tools/testing/selftests/membarrier/Makefile b/tools/testing/selftests/membarrier/Makefile
index ee5b9deb808b..c7fa0573e978 100644
--- a/tools/testing/selftests/membarrier/Makefile
+++ b/tools/testing/selftests/membarrier/Makefile
@@ -5,6 +5,7 @@ LDLIBS += -lpthread
 TEST_GEN_PROGS := membarrier_test_single_thread \
 		membarrier_test_multi_thread \
 		membarrier_test_ipi \
+		membarrier_test_cmd \
 		membarrier_rseq_stress
 
 LOCAL_HDRS += membarrier_test_impl.h
diff --git a/tools/testing/selftests/membarrier/membarrier_test_cmd.c b/tools/testing/selftests/membarrier/membarrier_test_cmd.c
new file mode 100644
index 000000000000..5982861f77b6
--- /dev/null
+++ b/tools/testing/selftests/membarrier/membarrier_test_cmd.c
@@ -0,0 +1,352 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Check the membarrier command arguments and the lifetime of the
+ * registrations.
+ *
+ * The test harness runs each test in its own process. This matters
+ * because a membarrier registration cannot be undone.
+ */
+#define _GNU_SOURCE
+#include <linux/membarrier.h>
+#include <sys/wait.h>
+#include <syscall.h>
+#include <limits.h>
+#include <pthread.h>
+#include <signal.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <sched.h>
+#include <errno.h>
+
+#include "kselftest_harness.h"
+
+#define STACK_SIZE	(64 * 1024)
+
+#define REGISTER_CMDS						\
+	(MEMBARRIER_CMD_REGISTER_GLOBAL_EXPEDITED |		\
+	 MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED |		\
+	 MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_SYNC_CORE |	\
+	 MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_RSEQ)
+
+/* Pairs of registration command and command which needs it. */
+static const struct {
+	int register_cmd;
+	int cmd;
+} private_cmds[] = {
+	{ MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED,
+	  MEMBARRIER_CMD_PRIVATE_EXPEDITED },
+	{ MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_SYNC_CORE,
+	  MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE },
+	{ MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_RSEQ,
+	  MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ },
+};
+
+static int sys_membarrier(int cmd, unsigned int flags, int cpu_id)
+{
+	return syscall(__NR_membarrier, cmd, flags, cpu_id);
+}
+
+static int query(void)
+{
+	return sys_membarrier(MEMBARRIER_CMD_QUERY, 0, 0);
+}
+
+static int get_registrations(void)
+{
+	return sys_membarrier(MEMBARRIER_CMD_GET_REGISTRATIONS, 0, 0);
+}
+
+/* Each command is either in the query mask or returns -EINVAL. */
+TEST(query_matches_commands)
+{
+	int mask = query(), bit, ret;
+
+	ASSERT_GE(mask, 0);
+	for (bit = 0; bit < 32; bit++) {
+		int cmd = (int)(1U << bit);
+
+		errno = 0;
+		ret = sys_membarrier(cmd, 0, 0);
+		if (mask & cmd) {
+			EXPECT_NE(errno, EINVAL) {
+				TH_LOG("command 0x%x is in the query mask", cmd);
+			}
+		} else {
+			EXPECT_EQ(ret, -1);
+			EXPECT_EQ(errno, EINVAL) {
+				TH_LOG("command 0x%x is not in the query mask", cmd);
+			}
+		}
+	}
+}
+
+/* A command is a single bit. */
+TEST(invalid_commands)
+{
+	static const int cmds[] = {
+		-1, INT_MAX,
+		MEMBARRIER_CMD_GLOBAL | MEMBARRIER_CMD_GLOBAL_EXPEDITED,
+		MEMBARRIER_CMD_PRIVATE_EXPEDITED |
+			MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED,
+	};
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(cmds); i++) {
+		EXPECT_EQ(sys_membarrier(cmds[i], 0, 0), -1);
+		EXPECT_EQ(errno, EINVAL);
+	}
+}
+
+/* Only the rseq command accepts a flag: MEMBARRIER_CMD_FLAG_CPU. */
+TEST(invalid_flags)
+{
+	static const unsigned int flags[] = {
+		MEMBARRIER_CMD_FLAG_CPU, 1U << 1, 1U << 31, ~0U,
+		MEMBARRIER_CMD_FLAG_CPU | (1U << 1),
+	};
+	int mask = query(), bit, i;
+
+	ASSERT_GE(mask, 0);
+	/* Bit -1 stands for MEMBARRIER_CMD_QUERY, which is 0. */
+	for (bit = -1; bit < 32; bit++) {
+		int cmd = bit < 0 ? MEMBARRIER_CMD_QUERY : (int)(1U << bit);
+
+		if (cmd && !(mask & cmd))
+			continue;
+		for (i = 0; i < ARRAY_SIZE(flags); i++) {
+			if (cmd == MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ &&
+			    flags[i] == MEMBARRIER_CMD_FLAG_CPU)
+				continue;
+			EXPECT_EQ(sys_membarrier(cmd, flags[i], 0), -1);
+			EXPECT_EQ(errno, EINVAL) {
+				TH_LOG("command 0x%x flags 0x%x", cmd, flags[i]);
+			}
+		}
+	}
+}
+
+/* A private command needs its own registration. */
+TEST(private_needs_registration)
+{
+	int mask = query(), registered = get_registrations(), i;
+
+	ASSERT_GE(mask, 0);
+	ASSERT_GE(registered, 0);
+	for (i = 0; i < ARRAY_SIZE(private_cmds); i++) {
+		if (!(mask & private_cmds[i].cmd))
+			continue;
+		/* The C library may have registered already. */
+		if (registered & private_cmds[i].register_cmd)
+			continue;
+		EXPECT_EQ(sys_membarrier(private_cmds[i].cmd, 0, 0), -1);
+		EXPECT_EQ(errno, EPERM);
+	}
+	if ((mask & MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ) &&
+	    !(registered & MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_RSEQ)) {
+		EXPECT_EQ(sys_membarrier(MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ,
+					 MEMBARRIER_CMD_FLAG_CPU, 0), -1);
+		EXPECT_EQ(errno, EPERM);
+	}
+}
+
+/*
+ * Issue one registration command. It must add its own bit to the
+ * registrations, and no other bit. It must allow its own command, and
+ * no other command.
+ */
+static void register_one(struct __test_metadata *_metadata, int register_cmd)
+{
+	int mask = query(), before = get_registrations(), i;
+
+	ASSERT_GE(mask, 0);
+	ASSERT_GE(before, 0);
+	if (!(mask & register_cmd))
+		SKIP(return, "command 0x%x is not available", register_cmd);
+	ASSERT_EQ(sys_membarrier(register_cmd, 0, 0), 0);
+	EXPECT_EQ(get_registrations(), before | register_cmd);
+	/* A second registration succeeds and changes nothing. */
+	ASSERT_EQ(sys_membarrier(register_cmd, 0, 0), 0);
+	EXPECT_EQ(get_registrations(), before | register_cmd);
+
+	for (i = 0; i < ARRAY_SIZE(private_cmds); i++) {
+		if (!(mask & private_cmds[i].cmd))
+			continue;
+		if ((before | register_cmd) & private_cmds[i].register_cmd) {
+			EXPECT_EQ(sys_membarrier(private_cmds[i].cmd, 0, 0), 0);
+		} else {
+			EXPECT_EQ(sys_membarrier(private_cmds[i].cmd, 0, 0), -1);
+			EXPECT_EQ(errno, EPERM);
+		}
+	}
+}
+
+TEST(register_global_expedited)
+{
+	register_one(_metadata, MEMBARRIER_CMD_REGISTER_GLOBAL_EXPEDITED);
+}
+
+TEST(register_private_expedited)
+{
+	register_one(_metadata, MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED);
+}
+
+TEST(register_private_expedited_sync_core)
+{
+	register_one(_metadata,
+		     MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_SYNC_CORE);
+}
+
+TEST(register_private_expedited_rseq)
+{
+	register_one(_metadata, MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_RSEQ);
+}
+
+/* Register every command, one at a time. Return the registrations. */
+static int register_all(struct __test_metadata *_metadata)
+{
+	int mask = query(), expected = get_registrations(), bit;
+
+	for (bit = 0; bit < 31; bit++) {
+		int cmd = 1 << bit;
+
+		if (!(cmd & REGISTER_CMDS & mask))
+			continue;
+		ASSERT_EQ(sys_membarrier(cmd, 0, 0), 0);
+		expected |= cmd;
+		EXPECT_EQ(get_registrations(), expected);
+	}
+	return expected;
+}
+
+TEST(register_all_commands)
+{
+	register_all(_metadata);
+}
+
+static void *thread_pause(void *arg)
+{
+	for (;;)
+		pause();
+	return NULL;
+}
+
+/*
+ * The rseq command accepts any CPU number. It ignores a CPU which does
+ * not exist. A negative CPU number selects all CPUs.
+ *
+ * The kernel only looks at the CPU number of a multi-threaded process,
+ * so keep a second thread alive.
+ */
+TEST(rseq_cpu_argument)
+{
+	static const int cpus[] = { 0, INT_MAX, -1, INT_MIN };
+	pthread_t thread;
+	int i;
+
+	if (!(query() & MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ))
+		SKIP(return, "the rseq command is not available");
+	ASSERT_EQ(pthread_create(&thread, NULL, thread_pause, NULL), 0);
+	ASSERT_EQ(sys_membarrier(MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_RSEQ,
+				 0, 0), 0);
+	EXPECT_EQ(sys_membarrier(MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ,
+				 MEMBARRIER_CMD_FLAG_CPU, sched_getcpu()), 0);
+	for (i = 0; i < ARRAY_SIZE(cpus); i++) {
+		EXPECT_EQ(sys_membarrier(MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ,
+					 MEMBARRIER_CMD_FLAG_CPU, cpus[i]), 0) {
+			TH_LOG("cpu_id %d", cpus[i]);
+		}
+	}
+	/* Without the flag, the CPU argument is ignored. */
+	EXPECT_EQ(sys_membarrier(MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ,
+				 0, INT_MAX), 0);
+}
+
+/* A forked child inherits the registrations. */
+TEST(fork_inherits_registrations)
+{
+	int expected = register_all(_metadata), status;
+	pid_t pid;
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+	if (!pid)
+		_exit(get_registrations() != expected);
+	ASSERT_EQ(waitpid(pid, &status, 0), pid);
+	EXPECT_TRUE(WIFEXITED(status));
+	EXPECT_EQ(WEXITSTATUS(status), 0);
+}
+
+/*
+ * exec() drops the registrations. The new program image starts with
+ * the registrations which this test program had when it started.
+ */
+static int initial_registrations;
+
+TEST(exec_drops_registrations)
+{
+	char expected[16];
+	int status;
+	pid_t pid;
+
+	register_all(_metadata);
+	snprintf(expected, sizeof(expected), "%d", initial_registrations);
+	pid = fork();
+	ASSERT_GE(pid, 0);
+	if (!pid) {
+		execl("/proc/self/exe", "membarrier_test_cmd",
+		      "--expect-registrations", expected, NULL);
+		_exit(2);
+	}
+	ASSERT_EQ(waitpid(pid, &status, 0), pid);
+	EXPECT_TRUE(WIFEXITED(status));
+	if (WEXITSTATUS(status) == 2)
+		SKIP(return, "cannot exec /proc/self/exe");
+	EXPECT_EQ(WEXITSTATUS(status), 0);
+}
+
+static int clone_vm_fn(void *arg)
+{
+	int cmd = *(int *)arg;
+
+	return sys_membarrier(cmd, 0, 0) ? 1 : 0;
+}
+
+/*
+ * The registrations belong to the mm. A task of another thread group
+ * which shares the mm (CLONE_VM without CLONE_THREAD) registers for
+ * both thread groups.
+ */
+TEST(clone_vm_shares_registrations)
+{
+	int cmd = MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED;
+	int before = get_registrations(), status;
+	char *stack;
+	pid_t pid;
+
+	ASSERT_GE(before, 0);
+	stack = malloc(STACK_SIZE);
+	ASSERT_NE(stack, NULL);
+	pid = clone(clone_vm_fn, stack + STACK_SIZE, CLONE_VM | SIGCHLD, &cmd);
+	ASSERT_GE(pid, 0);
+	ASSERT_EQ(waitpid(pid, &status, 0), pid);
+	EXPECT_TRUE(WIFEXITED(status));
+	EXPECT_EQ(WEXITSTATUS(status), 0);
+	EXPECT_EQ(get_registrations(), before | cmd);
+	EXPECT_EQ(sys_membarrier(MEMBARRIER_CMD_PRIVATE_EXPEDITED, 0, 0), 0);
+	free(stack);
+}
+
+int main(int argc, char **argv)
+{
+	/* New program image of exec_drops_registrations. */
+	if (argc == 3 && !strcmp(argv[1], "--expect-registrations"))
+		return get_registrations() != atoi(argv[2]);
+
+	if (query() < 0)
+		ksft_exit_skip("sys membarrier (CONFIG_MEMBARRIER) is disabled.\n");
+	initial_registrations = get_registrations();
+	if (initial_registrations < 0)
+		ksft_exit_skip("MEMBARRIER_CMD_GET_REGISTRATIONS is not available.\n");
+	return test_harness_run(argc, argv);
+}
-- 
2.47.3


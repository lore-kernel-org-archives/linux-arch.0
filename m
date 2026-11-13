Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794575961;
	b=4Fa0Yh4QNuiP8XZSzGc60T6TAd6gtw/mkDydBSk5eZ+fWjftVrvp4GZi0unHDEfmw4d4
	 mwtP2+skzSa0MarTxnxnc6WWnfa0opa3IneBWNfEXEQ6+q/erBV/nAj7Bmr06RZvhLsTZ
	 7ConH0FJgmqWQA2OXs9P+tVWWYuqKIP0osbH1vIupgZC1T/C4Ubxr10UJ/iWWYIm14oTa
	 VkQ6Cq3ZzbOVpVFYpz/rJzZak/zAtCitcDmZIQTFmDTfEzyx+pxkw0Qn+NpZQhn16wNHQ
	 kbng2QmdJmyRPFUDcXrNfgtKTMZlF2VSaTG8dZDdPl2fID5T4VcFmT1UOVIs7zOh6nQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794575961;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=3orQFE08kjrTAUJE8mLYeXKLSOzKBUY432bsO80CLow=;
	b=wyyIbzlrTeOkJKiOuii5EiEiQOcYx8M8EPPUh1lysxjThbyWM1GmGK/rmptd+JrSijwB
	 wH2O2owlxk0qYhvXiQcESADcUZ9FPbA2V6lSMmMTxbgBqiHMq6x6UvBL+zlTddQ57TljW
	 IOqhsmZMyXZ6mg3fTOylEmVffD0QA/LJibnbkM+3Sg5RMrq8J+lEugVlOJqTYzNbQmGQQ
	 TrDpQQ6EzGF+k6+bVniE5WgYEDJgT+886Z0fD0qGR983r+2Zvps/h02APhqe+1cmy0+JE
	 rW7/VEgLUyyyYZPCBhHmnetBaaiGGh6ajCvnK29T4RRnqmj8R333IovLLIMbWinyUfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=uWHc25xk;
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1438C606B54B;
	Fri, 13 Nov 2026 13:19:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1438C606B54B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=uWHc25xk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1794575951;
	bh=3orQFE08kjrTAUJE8mLYeXKLSOzKBUY432bsO80CLow=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uWHc25xkEzUhxWbyBYK+mBLyFTPwhGDwng3vVihPa2/Qd4UVRuC0+vpkveKgCrTkQ
	 qGgPlNv4CBc9/lMbprYKZsd/xNIk0B1rlO9DI6n3l2RYdhGosC2/yJi9IucisbfiW3
	 rVgksakI3AVD5Uio2smeAOaCPDD3B0zGI2TGa4CpSawa90yucRZeo++uXRfhQe5D54
	 3oPh58+5D2dm2BhffY45Ytk+/CHaSiPQXwdkWqvi3rY5XEFUVmGvRUlpH3SMXFvpTa
	 s0EEqAS1tr0FZYbuRdRRfYtI+zMXrOtyUv+LloHzkWQofhhsnqtKlGWIcY0GXfTj91
	 5qt6TsNhiakbw==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jQyWz5l1pzQ55;
	Fri, 13 Nov 2026 08:19:11 -0500 (EST)
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
Subject: [RFC PATCH 13/16] selftests/membarrier: Add litmus tests of the memory ordering
Date: Fri, 13 Nov 2026 08:19:00 -0500
Message-Id: <20261113131903.157186-14-mathieu.desnoyers@efficios.com>
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

membarrier relies on memory barriers in the system call, in its IPI
handler and in the scheduler. The comment at the top of
kernel/sched/membarrier.c describes the scenarios. A test on real
hardware can check that the kernel executes a barrier. It cannot show
that the barrier is needed: a missing barrier may never fail in
practice.

Check these scenarios with the Linux kernel memory model instead.
The litmus tests cover:

 - a thread which runs after the IPI, scenario (A),
 - a thread which ran before the IPI, scenario (B),
 - a thread which is scheduled in while membarrier() sees another
   task in rq->curr, scenarios (A) and (C),
 - a thread which is scheduled out before membarrier() loads
   rq->curr, scenarios (B) and (C).

herd7 reports "Never" for these 4 tests. 9 variants drop one barrier
each, and herd7 reports "Sometimes" for them. One of the variants
replaces the full barrier after the store to rq->curr with
smp_store_release(). This is the LoongArch and parisc case.

The README describes the model and how to run the tests.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 kernel/sched/membarrier.c                     |  3 ++
 .../selftests/membarrier/litmus/README        | 52 +++++++++++++++++++
 .../litmus/ipi-after-thread-no-exit-mb.litmus | 36 +++++++++++++
 .../ipi-after-thread-no-handler-mb.litmus     | 36 +++++++++++++
 .../membarrier/litmus/ipi-after-thread.litmus | 47 +++++++++++++++++
 .../ipi-before-thread-no-entry-mb.litmus      | 37 +++++++++++++
 .../ipi-before-thread-no-handler-mb.litmus    | 37 +++++++++++++
 .../litmus/ipi-before-thread.litmus           | 46 ++++++++++++++++
 .../litmus/sched-in-no-entry-mb.litmus        | 34 ++++++++++++
 .../membarrier/litmus/sched-in-no-mb.litmus   | 33 ++++++++++++
 .../membarrier/litmus/sched-in-release.litmus | 38 ++++++++++++++
 .../membarrier/litmus/sched-in.litmus         | 51 ++++++++++++++++++
 .../litmus/sched-out-no-exit-mb.litmus        | 34 ++++++++++++
 .../litmus/sched-out-no-sched-mb.litmus       | 34 ++++++++++++
 .../membarrier/litmus/sched-out.litmus        | 49 +++++++++++++++++
 15 files changed, 567 insertions(+)
 create mode 100644 tools/testing/selftests/membarrier/litmus/README
 create mode 100644 tools/testing/selftests/membarrier/litmus/ipi-after-thread-no-exit-mb.litmus
 create mode 100644 tools/testing/selftests/membarrier/litmus/ipi-after-thread-no-handler-mb.litmus
 create mode 100644 tools/testing/selftests/membarrier/litmus/ipi-after-thread.litmus
 create mode 100644 tools/testing/selftests/membarrier/litmus/ipi-before-thread-no-entry-mb.litmus
 create mode 100644 tools/testing/selftests/membarrier/litmus/ipi-before-thread-no-handler-mb.litmus
 create mode 100644 tools/testing/selftests/membarrier/litmus/ipi-before-thread.litmus
 create mode 100644 tools/testing/selftests/membarrier/litmus/sched-in-no-entry-mb.litmus
 create mode 100644 tools/testing/selftests/membarrier/litmus/sched-in-no-mb.litmus
 create mode 100644 tools/testing/selftests/membarrier/litmus/sched-in-release.litmus
 create mode 100644 tools/testing/selftests/membarrier/litmus/sched-in.litmus
 create mode 100644 tools/testing/selftests/membarrier/litmus/sched-out-no-exit-mb.litmus
 create mode 100644 tools/testing/selftests/membarrier/litmus/sched-out-no-sched-mb.litmus
 create mode 100644 tools/testing/selftests/membarrier/litmus/sched-out.litmus

diff --git a/kernel/sched/membarrier.c b/kernel/sched/membarrier.c
index 46e823a3d668..5dd88ac0957b 100644
--- a/kernel/sched/membarrier.c
+++ b/kernel/sched/membarrier.c
@@ -133,6 +133,9 @@
  * Using the scenario from (A), we can show that (a) needs to be paired
  * with (g). Using the scenario from (B), we can show that (c) needs to
  * be paired with (d).
+ *
+ * The litmus tests in tools/testing/selftests/membarrier/litmus check
+ * these scenarios with the Linux kernel memory model.
  */
 
 /*
diff --git a/tools/testing/selftests/membarrier/litmus/README b/tools/testing/selftests/membarrier/litmus/README
new file mode 100644
index 000000000000..c9ae572a9d43
--- /dev/null
+++ b/tools/testing/selftests/membarrier/litmus/README
@@ -0,0 +1,52 @@
+Litmus tests of the membarrier system call. They check the memory
+ordering scenarios of kernel/sched/membarrier.c with the Linux kernel
+memory model. Each test with the result "Never" models a case of
+these scenarios. A test with the result "Sometimes" drops one
+barrier, to show that the scenario needs it.
+
+In each test, P0 is the caller of membarrier(). P1 is a CPU which runs
+a thread of the target process.
+
+The user-space accesses of the thread are WRITE_ONCE() and READ_ONCE()
+in program order, without a memory barrier between them. This is what
+barrier() gives in user-space code.
+
+The model has no interrupt. The IPI is modeled as a request and an
+acknowledgment: the caller stores "req", the handler loads it, issues
+its memory barrier and stores "ack", and the caller loads "ack". The
+"exists" clause of each test keeps the executions where this exchange
+took place.
+
+Run them from tools/memory-model, with herd7 installed:
+
+  cd tools/memory-model
+  for f in ../testing/selftests/membarrier/litmus/*.litmus; do
+	herd7 -conf linux-kernel.cfg $f | grep Observation
+  done
+
+Each observation must match the "Result" in the comment of its test.
+
+The thread is interrupted by the IPI:
+
+  ipi-before-thread.litmus, ipi-before-thread-no-entry-mb.litmus,
+  ipi-before-thread-no-handler-mb.litmus
+    Scenario (A). The thread runs after the IPI. It sees the stores
+    which the caller did before membarrier().
+
+  ipi-after-thread.litmus, ipi-after-thread-no-exit-mb.litmus,
+  ipi-after-thread-no-handler-mb.litmus
+    Scenario (B). The thread ran before the IPI. The caller sees its
+    stores after membarrier().
+
+The caller sees another task in rq->curr and sends no IPI:
+
+  sched-in.litmus, sched-in-no-entry-mb.litmus, sched-in-no-mb.litmus,
+  sched-in-release.litmus
+    Scenarios (A) and (C). The thread is scheduled in. The scheduler
+    issues a full barrier after the store to rq->curr. An
+    smp_store_release() which is not a full barrier is not enough.
+
+  sched-out.litmus, sched-out-no-exit-mb.litmus,
+  sched-out-no-sched-mb.litmus
+    Scenarios (B) and (C). The thread is scheduled out. The scheduler
+    issues a full barrier before the store to rq->curr.
diff --git a/tools/testing/selftests/membarrier/litmus/ipi-after-thread-no-exit-mb.litmus b/tools/testing/selftests/membarrier/litmus/ipi-after-thread-no-exit-mb.litmus
new file mode 100644
index 000000000000..fb67beaba996
--- /dev/null
+++ b/tools/testing/selftests/membarrier/litmus/ipi-after-thread-no-exit-mb.litmus
@@ -0,0 +1,36 @@
+C ipi-after-thread-no-exit-mb
+
+(*
+ * Result: Sometimes
+ *
+ * ipi-after-thread without the barrier (c) at the end of membarrier().
+ * The load of x by P0 can then be done before the IPI completes.
+ *)
+
+{}
+
+P0(int *x, int *y, int *req, int *ack)
+{
+	int r_ack;
+	int r1;
+	int r2;
+
+	r2 = READ_ONCE(*y);
+	smp_mb();
+	WRITE_ONCE(*req, 1);
+	r_ack = READ_ONCE(*ack);
+	r1 = READ_ONCE(*x);
+}
+
+P1(int *x, int *y, int *req, int *ack)
+{
+	int r_req;
+
+	WRITE_ONCE(*x, 1);
+	WRITE_ONCE(*y, 1);
+	r_req = READ_ONCE(*req);
+	smp_mb();
+	WRITE_ONCE(*ack, 1);
+}
+
+exists (0:r2=1 /\ 1:r_req=1 /\ 0:r_ack=1 /\ 0:r1=0)
diff --git a/tools/testing/selftests/membarrier/litmus/ipi-after-thread-no-handler-mb.litmus b/tools/testing/selftests/membarrier/litmus/ipi-after-thread-no-handler-mb.litmus
new file mode 100644
index 000000000000..687e883850a9
--- /dev/null
+++ b/tools/testing/selftests/membarrier/litmus/ipi-after-thread-no-handler-mb.litmus
@@ -0,0 +1,36 @@
+C ipi-after-thread-no-handler-mb
+
+(*
+ * Result: Sometimes
+ *
+ * ipi-after-thread without the barrier in the IPI handler. The store to
+ * x by P1 can then be delayed past the acknowledgment.
+ *)
+
+{}
+
+P0(int *x, int *y, int *req, int *ack)
+{
+	int r_ack;
+	int r1;
+	int r2;
+
+	r2 = READ_ONCE(*y);
+	smp_mb();
+	WRITE_ONCE(*req, 1);
+	r_ack = READ_ONCE(*ack);
+	smp_mb();
+	r1 = READ_ONCE(*x);
+}
+
+P1(int *x, int *y, int *req, int *ack)
+{
+	int r_req;
+
+	WRITE_ONCE(*x, 1);
+	WRITE_ONCE(*y, 1);
+	r_req = READ_ONCE(*req);
+	WRITE_ONCE(*ack, 1);
+}
+
+exists (0:r2=1 /\ 1:r_req=1 /\ 0:r_ack=1 /\ 0:r1=0)
diff --git a/tools/testing/selftests/membarrier/litmus/ipi-after-thread.litmus b/tools/testing/selftests/membarrier/litmus/ipi-after-thread.litmus
new file mode 100644
index 000000000000..1145faf62b6d
--- /dev/null
+++ b/tools/testing/selftests/membarrier/litmus/ipi-after-thread.litmus
@@ -0,0 +1,47 @@
+C ipi-after-thread
+
+(*
+ * Result: Never
+ *
+ * Scenario (B) of kernel/sched/membarrier.c.
+ *
+ * P1 is a user-space thread which runs "x = 1; y = 1" in program order,
+ * without a memory barrier. The IPI of membarrier() interrupts it after
+ * that. P0 reads y before membarrier() and x after it.
+ *
+ * req and ack model the IPI, see README.
+ *
+ * The barrier in the IPI handler orders both stores before the
+ * acknowledgment. The barrier (c) at the end of membarrier() orders the
+ * acknowledgment before "r1 = x". P0 thus sees x == 1. This holds
+ * whatever P0 read from y: y is kept to match the scenario.
+ *)
+
+{}
+
+P0(int *x, int *y, int *req, int *ack)
+{
+	int r_ack;
+	int r1;
+	int r2;
+
+	r2 = READ_ONCE(*y);
+	smp_mb();
+	WRITE_ONCE(*req, 1);
+	r_ack = READ_ONCE(*ack);
+	smp_mb();
+	r1 = READ_ONCE(*x);
+}
+
+P1(int *x, int *y, int *req, int *ack)
+{
+	int r_req;
+
+	WRITE_ONCE(*x, 1);
+	WRITE_ONCE(*y, 1);
+	r_req = READ_ONCE(*req);
+	smp_mb();
+	WRITE_ONCE(*ack, 1);
+}
+
+exists (0:r2=1 /\ 1:r_req=1 /\ 0:r_ack=1 /\ 0:r1=0)
diff --git a/tools/testing/selftests/membarrier/litmus/ipi-before-thread-no-entry-mb.litmus b/tools/testing/selftests/membarrier/litmus/ipi-before-thread-no-entry-mb.litmus
new file mode 100644
index 000000000000..9685e34e224a
--- /dev/null
+++ b/tools/testing/selftests/membarrier/litmus/ipi-before-thread-no-entry-mb.litmus
@@ -0,0 +1,37 @@
+C ipi-before-thread-no-entry-mb
+
+(*
+ * Result: Sometimes
+ *
+ * ipi-before-thread without the barrier (a) at the start of
+ * membarrier(). The store to x can be delayed past the IPI. P1 and P0
+ * then both read 0.
+ *)
+
+{}
+
+P0(int *x, int *y, int *req, int *ack)
+{
+	int r_ack;
+	int r2;
+
+	WRITE_ONCE(*x, 1);
+	WRITE_ONCE(*req, 1);
+	r_ack = READ_ONCE(*ack);
+	smp_mb();
+	r2 = READ_ONCE(*y);
+}
+
+P1(int *x, int *y, int *req, int *ack)
+{
+	int r_req;
+	int r1;
+
+	r_req = READ_ONCE(*req);
+	smp_mb();
+	WRITE_ONCE(*ack, 1);
+	WRITE_ONCE(*y, 1);
+	r1 = READ_ONCE(*x);
+}
+
+exists (1:r_req=1 /\ 0:r_ack=1 /\ 1:r1=0 /\ 0:r2=0)
diff --git a/tools/testing/selftests/membarrier/litmus/ipi-before-thread-no-handler-mb.litmus b/tools/testing/selftests/membarrier/litmus/ipi-before-thread-no-handler-mb.litmus
new file mode 100644
index 000000000000..1559bce76ea5
--- /dev/null
+++ b/tools/testing/selftests/membarrier/litmus/ipi-before-thread-no-handler-mb.litmus
@@ -0,0 +1,37 @@
+C ipi-before-thread-no-handler-mb
+
+(*
+ * Result: Sometimes
+ *
+ * ipi-before-thread without the barrier in the IPI handler. The load of
+ * x by P1 can then be done before the handler loads req. This is why
+ * ipi_mb() issues smp_mb() rather than rely on the interrupt alone.
+ *)
+
+{}
+
+P0(int *x, int *y, int *req, int *ack)
+{
+	int r_ack;
+	int r2;
+
+	WRITE_ONCE(*x, 1);
+	smp_mb();
+	WRITE_ONCE(*req, 1);
+	r_ack = READ_ONCE(*ack);
+	smp_mb();
+	r2 = READ_ONCE(*y);
+}
+
+P1(int *x, int *y, int *req, int *ack)
+{
+	int r_req;
+	int r1;
+
+	r_req = READ_ONCE(*req);
+	WRITE_ONCE(*ack, 1);
+	WRITE_ONCE(*y, 1);
+	r1 = READ_ONCE(*x);
+}
+
+exists (1:r_req=1 /\ 0:r_ack=1 /\ 1:r1=0 /\ 0:r2=0)
diff --git a/tools/testing/selftests/membarrier/litmus/ipi-before-thread.litmus b/tools/testing/selftests/membarrier/litmus/ipi-before-thread.litmus
new file mode 100644
index 000000000000..e21e79e2d2ad
--- /dev/null
+++ b/tools/testing/selftests/membarrier/litmus/ipi-before-thread.litmus
@@ -0,0 +1,46 @@
+C ipi-before-thread
+
+(*
+ * Result: Never
+ *
+ * Scenario (A) of kernel/sched/membarrier.c.
+ *
+ * P0 calls membarrier(). P1 is a user-space thread which the IPI
+ * interrupts before it runs "y = 1; r1 = x". Its two accesses are in
+ * program order, without a memory barrier.
+ *
+ * req and ack model the IPI, see README.
+ *
+ * The barrier (a) at the start of membarrier() orders "x = 1" before
+ * the IPI. P1 thus sees x == 1 after the IPI. This holds whatever P0
+ * reads from y: y is kept to match the scenario.
+ *)
+
+{}
+
+P0(int *x, int *y, int *req, int *ack)
+{
+	int r_ack;
+	int r2;
+
+	WRITE_ONCE(*x, 1);
+	smp_mb();
+	WRITE_ONCE(*req, 1);
+	r_ack = READ_ONCE(*ack);
+	smp_mb();
+	r2 = READ_ONCE(*y);
+}
+
+P1(int *x, int *y, int *req, int *ack)
+{
+	int r_req;
+	int r1;
+
+	r_req = READ_ONCE(*req);
+	smp_mb();
+	WRITE_ONCE(*ack, 1);
+	WRITE_ONCE(*y, 1);
+	r1 = READ_ONCE(*x);
+}
+
+exists (1:r_req=1 /\ 0:r_ack=1 /\ 1:r1=0 /\ 0:r2=0)
diff --git a/tools/testing/selftests/membarrier/litmus/sched-in-no-entry-mb.litmus b/tools/testing/selftests/membarrier/litmus/sched-in-no-entry-mb.litmus
new file mode 100644
index 000000000000..a40837fad005
--- /dev/null
+++ b/tools/testing/selftests/membarrier/litmus/sched-in-no-entry-mb.litmus
@@ -0,0 +1,34 @@
+C sched-in-no-entry-mb
+
+(*
+ * Result: Sometimes
+ *
+ * sched-in without the barrier (a) at the start of membarrier(). The
+ * store to x can be delayed past the load of rq->curr. P0 sees no
+ * thread and sends no IPI. The thread reads x == 0.
+ *)
+
+{}
+
+P0(int *x, int *y, int *curr)
+{
+	int r_curr;
+	int r2;
+
+	WRITE_ONCE(*x, 1);
+	r_curr = READ_ONCE(*curr);
+	smp_mb();
+	r2 = READ_ONCE(*y);
+}
+
+P1(int *x, int *y, int *curr)
+{
+	int r1;
+
+	WRITE_ONCE(*curr, 1);
+	smp_mb();
+	WRITE_ONCE(*y, 1);
+	r1 = READ_ONCE(*x);
+}
+
+exists (0:r_curr=0 /\ 1:r1=0 /\ 0:r2=0)
diff --git a/tools/testing/selftests/membarrier/litmus/sched-in-no-mb.litmus b/tools/testing/selftests/membarrier/litmus/sched-in-no-mb.litmus
new file mode 100644
index 000000000000..6840cb26e13d
--- /dev/null
+++ b/tools/testing/selftests/membarrier/litmus/sched-in-no-mb.litmus
@@ -0,0 +1,33 @@
+C sched-in-no-mb
+
+(*
+ * Result: Sometimes
+ *
+ * sched-in without the full barrier after the store to rq->curr. P0
+ * sees no thread and sends no IPI. The thread reads x == 0.
+ *)
+
+{}
+
+P0(int *x, int *y, int *curr)
+{
+	int r_curr;
+	int r2;
+
+	WRITE_ONCE(*x, 1);
+	smp_mb();
+	r_curr = READ_ONCE(*curr);
+	smp_mb();
+	r2 = READ_ONCE(*y);
+}
+
+P1(int *x, int *y, int *curr)
+{
+	int r1;
+
+	WRITE_ONCE(*curr, 1);
+	WRITE_ONCE(*y, 1);
+	r1 = READ_ONCE(*x);
+}
+
+exists (0:r_curr=0 /\ 1:r1=0 /\ 0:r2=0)
diff --git a/tools/testing/selftests/membarrier/litmus/sched-in-release.litmus b/tools/testing/selftests/membarrier/litmus/sched-in-release.litmus
new file mode 100644
index 000000000000..d2df75b388fe
--- /dev/null
+++ b/tools/testing/selftests/membarrier/litmus/sched-in-release.litmus
@@ -0,0 +1,38 @@
+C sched-in-release
+
+(*
+ * Result: Sometimes
+ *
+ * sched-in with smp_store_release() in place of the full barrier after
+ * the store to rq->curr. This is finish_task() on an architecture where
+ * smp_store_release() is weaker than a full barrier. It does not order
+ * the store to rq->curr before the loads of the thread.
+ *)
+
+{
+	int on_cpu = 1;
+}
+
+P0(int *x, int *y, int *curr)
+{
+	int r_curr;
+	int r2;
+
+	WRITE_ONCE(*x, 1);
+	smp_mb();
+	r_curr = READ_ONCE(*curr);
+	smp_mb();
+	r2 = READ_ONCE(*y);
+}
+
+P1(int *x, int *y, int *curr, int *on_cpu)
+{
+	int r1;
+
+	WRITE_ONCE(*curr, 1);
+	smp_store_release(on_cpu, 0);
+	WRITE_ONCE(*y, 1);
+	r1 = READ_ONCE(*x);
+}
+
+exists (0:r_curr=0 /\ 1:r1=0 /\ 0:r2=0)
diff --git a/tools/testing/selftests/membarrier/litmus/sched-in.litmus b/tools/testing/selftests/membarrier/litmus/sched-in.litmus
new file mode 100644
index 000000000000..c89e2c6c4554
--- /dev/null
+++ b/tools/testing/selftests/membarrier/litmus/sched-in.litmus
@@ -0,0 +1,51 @@
+C sched-in
+
+(*
+ * Result: Never
+ *
+ * Scenarios (A) and (C) of kernel/sched/membarrier.c: a thread of the
+ * target process is scheduled in while P0 calls membarrier().
+ *
+ * curr stands for rq->curr of the CPU of P1: 0 for another task, 1 for
+ * the thread. P0 loads it between its two barriers. It sends no IPI
+ * when it reads 0, which is the case the "exists" clause keeps.
+ *
+ * P1 is the scheduler, then the thread in user-space. The scheduler
+ * stores to rq->curr, then issues a full barrier before the return to
+ * user-space. Each architecture provides this barrier its own way, see
+ * Documentation/scheduler/membarrier.rst.
+ *
+ * Either P0 sees the thread and sends the IPI, or the thread sees
+ * x == 1. This holds whatever P0 reads from y: y is kept to match the
+ * scenario.
+ *
+ * The same argument holds with tsk->mm in place of rq->curr. It covers
+ * kthread_use_mm(), scenario (E), and the icache_stale_mask of the
+ * RISC-V sync core command.
+ *)
+
+{}
+
+P0(int *x, int *y, int *curr)
+{
+	int r_curr;
+	int r2;
+
+	WRITE_ONCE(*x, 1);
+	smp_mb();
+	r_curr = READ_ONCE(*curr);
+	smp_mb();
+	r2 = READ_ONCE(*y);
+}
+
+P1(int *x, int *y, int *curr)
+{
+	int r1;
+
+	WRITE_ONCE(*curr, 1);
+	smp_mb();
+	WRITE_ONCE(*y, 1);
+	r1 = READ_ONCE(*x);
+}
+
+exists (0:r_curr=0 /\ 1:r1=0 /\ 0:r2=0)
diff --git a/tools/testing/selftests/membarrier/litmus/sched-out-no-exit-mb.litmus b/tools/testing/selftests/membarrier/litmus/sched-out-no-exit-mb.litmus
new file mode 100644
index 000000000000..e4bb1ee7a935
--- /dev/null
+++ b/tools/testing/selftests/membarrier/litmus/sched-out-no-exit-mb.litmus
@@ -0,0 +1,34 @@
+C sched-out-no-exit-mb
+
+(*
+ * Result: Sometimes
+ *
+ * sched-out without the barrier (c) at the end of membarrier(). The
+ * load of x by P0 can then be done before it loads rq->curr.
+ *)
+
+{
+	int curr = 1;
+}
+
+P0(int *x, int *y, int *curr)
+{
+	int r_curr;
+	int r1;
+	int r2;
+
+	r2 = READ_ONCE(*y);
+	smp_mb();
+	r_curr = READ_ONCE(*curr);
+	r1 = READ_ONCE(*x);
+}
+
+P1(int *x, int *y, int *curr)
+{
+	WRITE_ONCE(*x, 1);
+	WRITE_ONCE(*y, 1);
+	smp_mb();
+	WRITE_ONCE(*curr, 0);
+}
+
+exists (0:r2=1 /\ 0:r_curr=0 /\ 0:r1=0)
diff --git a/tools/testing/selftests/membarrier/litmus/sched-out-no-sched-mb.litmus b/tools/testing/selftests/membarrier/litmus/sched-out-no-sched-mb.litmus
new file mode 100644
index 000000000000..7b690db2b4be
--- /dev/null
+++ b/tools/testing/selftests/membarrier/litmus/sched-out-no-sched-mb.litmus
@@ -0,0 +1,34 @@
+C sched-out-no-sched-mb
+
+(*
+ * Result: Sometimes
+ *
+ * sched-out without the full barrier before the store to rq->curr. The
+ * store to x by the thread can then be delayed past it.
+ *)
+
+{
+	int curr = 1;
+}
+
+P0(int *x, int *y, int *curr)
+{
+	int r_curr;
+	int r1;
+	int r2;
+
+	r2 = READ_ONCE(*y);
+	smp_mb();
+	r_curr = READ_ONCE(*curr);
+	smp_mb();
+	r1 = READ_ONCE(*x);
+}
+
+P1(int *x, int *y, int *curr)
+{
+	WRITE_ONCE(*x, 1);
+	WRITE_ONCE(*y, 1);
+	WRITE_ONCE(*curr, 0);
+}
+
+exists (0:r2=1 /\ 0:r_curr=0 /\ 0:r1=0)
diff --git a/tools/testing/selftests/membarrier/litmus/sched-out.litmus b/tools/testing/selftests/membarrier/litmus/sched-out.litmus
new file mode 100644
index 000000000000..8fb1532bd13c
--- /dev/null
+++ b/tools/testing/selftests/membarrier/litmus/sched-out.litmus
@@ -0,0 +1,49 @@
+C sched-out
+
+(*
+ * Result: Never
+ *
+ * Scenarios (B) and (C) of kernel/sched/membarrier.c: a thread of the
+ * target process is scheduled out while P0 calls membarrier().
+ *
+ * curr stands for rq->curr of the CPU of P1: 1 for the thread, 0 for
+ * another task. P0 sends no IPI when it reads 0, which is the case the
+ * "exists" clause keeps.
+ *
+ * P1 is the thread in user-space, which runs "x = 1; y = 1" in program
+ * order. Then the scheduler issues a full barrier before it stores to
+ * rq->curr: smp_mb__after_spinlock() in __schedule().
+ *
+ * When P0 saw y == 1 and sees that the thread is gone, it sees x == 1.
+ * This holds whatever P0 read from y: y is kept to match the scenario.
+ *
+ * The same argument holds with tsk->mm in place of rq->curr. It covers
+ * exit_mm(), scenario (D), and kthread_unuse_mm(), scenario (E).
+ *)
+
+{
+	int curr = 1;
+}
+
+P0(int *x, int *y, int *curr)
+{
+	int r_curr;
+	int r1;
+	int r2;
+
+	r2 = READ_ONCE(*y);
+	smp_mb();
+	r_curr = READ_ONCE(*curr);
+	smp_mb();
+	r1 = READ_ONCE(*x);
+}
+
+P1(int *x, int *y, int *curr)
+{
+	WRITE_ONCE(*x, 1);
+	WRITE_ONCE(*y, 1);
+	smp_mb();
+	WRITE_ONCE(*curr, 0);
+}
+
+exists (0:r2=1 /\ 0:r_curr=0 /\ 0:r1=0)
-- 
2.47.3


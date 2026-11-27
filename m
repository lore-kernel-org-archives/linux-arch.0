Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795784941;
	b=QRRslmfsZGinz0RtwSGgaGT5ECyREypJ2hiG2/Dft0pBd6Po1vq+vUprwmMjFFYIBoiE
	 irKDTgGd5aaD1JQDGxGAM2POhnxMdIM2NbL5sAXqz7x33zpeijo3MIoOPJB6SFAFO1VJs
	 THpKkVqx3LNvpSN3ZjLr49wZWgxHyUgQp4keH24IMtM47nyLoRAhMBzPxJEVFnFG7A3Ir
	 TudTxFooxTh8YKr3XPsrf3+wCKK3A8VLaZGCJI/9+2gKrLi6UWT5CWQPIsMxW96cSRs2Q
	 CkXPKwXyb61Q6boPc9Vwgr6r6uKG/TqL8VFlisVGGFf5V2f+H1/ZJej04gZ+Kj+wjsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795784941;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=xpYGwpzhSFj5mhADUVjX+MmKt0XMajSbA4YBk2TSp28=;
	b=gCdJdomC/v0/a35CnggPcbIB6XdjI5dEx6PmjH6eQjpdNi76CMM1zqFbqO2EeJShJkhZ
	 j5/dJJWsobgnKDwaa1RV8FK57RA5I8JgksZScw45Iy52Hif/QCpr3UpXY1R4+BB4vvzz6
	 vDM0m954UxXbwSsuUmdMaTzeV1lpAbLBpdKIygAvxvU3Lmndt5xSNBwvlK6N3RTu2dXNZ
	 PYuTtBTR5LTgWsuVKiXUHoz5FFPsRWSj1Y1UdEolH1ckgYonznJ5WxX7Q9baF7g0bsGks
	 CJAqkj844JOOhh4CWq7Z0A+qMwjMBm5oopABNdbYmS5sHz0XviWxaqxQlG92Yjd/kVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--elver.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NX3QRZWf;
	arc=none smtp.remote-ip=209.85.221.70
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7A1606A31F
	for <linux-arch@vger.kernel.org>; Fri, 27 Nov 2026 13:09:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D7A1606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NX3QRZWf
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-48e0ef019a4so5073355f8f.3
        for <linux-arch@vger.kernel.org>; Fri, 27 Nov 2026 05:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795784939; x=1796389739; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xpYGwpzhSFj5mhADUVjX+MmKt0XMajSbA4YBk2TSp28=;
        b=NX3QRZWfnFEkj/AZGNnWoVh+ECESLbUA6XXt3Ff0rW99OaP48k31e/FBihUguiRFFR
         PKU+esbL+LA0uwdi/MdbdIX35UZ8wQ2HNoZt6jZABFQugqAOcu4tAMFRs0+dH33dFqtA
         4WDVnRRMgGh1og8uKz6MGx2vFUf+vY+PVgHJZ3h7P/1WWt2kGa/sbI7JScjGiV7as2Nm
         FT7kgtXbLsYYpRLM14/bJZtlW4j+uDRwx9Tp4Yl5XxGXeop963IgnW1eYWVE88QLltTm
         loNTzQDuUzB5UthY7QH1yY++EKTaRysMh1oqZxTtTNDuFIOVE2eNx66761d+jLDlim2Z
         R3pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795784939; x=1796389739;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xpYGwpzhSFj5mhADUVjX+MmKt0XMajSbA4YBk2TSp28=;
        b=OUVoYRqC+YbKZWsZwf6VMNDBgB7dGLHq3nKfq7W8EDIZXaTaEETLG6VqVyMJf+al6x
         L+8VSynpjKes/7Gc89jdD1nfWtILyJRq4R5suLkZB/93oqGLAymcKmIjiAM+ZNStziXy
         N76j/JOyvEThf6QBCBQJ0oW5Du7JhmyvCrQmRJySlPt7RwE/Hr+s8ZWMMIMWT9TqBC2g
         xGD24oEr6peY5qa23Hhh4FC58WklASfGTEQoV2lasI+VmAvy082wsdsrXswynNR0KslA
         CGvUXQWvsTrkCEkyAl2WEZ869GEI6EXJazpwgucwdBFGkeqaPPxPGbTYGN5Fb1tkTCsv
         PAwg==
X-Forwarded-Encrypted: i=1; AL+hErHAqYTPABhigqWoOYLR57PXmNkvFWhTfyotD2VR+zYx8uHnqpF1s4F92EJh0OazgNvwO9eXDJFHTt02@vger.kernel.org
X-Gm-Message-State: APuU4Z8LJuwOBPVggohjIZ1mRLrL40FUlKGOixHcGaQg7w5Mj+I1BrrN
	yYHAaR4Y0TDXMxXcD2ReQxqVs6Pud59NJzqGPj7uHPV8KxVpecqcEMHNFIA2k+Y23tpxddAX97z
	nNw==
X-Received: from wrmk12.prod.google.com ([2002:adf:e3cc:0:b0:49b:2420:f8db])
 (user=elver job=prod-delivery.src-stubby-dispatcher) by 2002:a5d:5c05:0:b0:4b7:6ea2:472d
 with SMTP id ffacd0b85a97d-4b76ea247b3mr25042347f8f.7.1795784938541; Fri, 27
 Nov 2026 05:08:58 -0800 (PST)
Date: Fri, 27 Nov 2026 13:08:32 +0000
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
Message-ID: <20261127130850.3343364-1-elver@google.com>
Subject: [PATCH v2] kcsan: Detect cross-CPU races on {READ,WRITE}_ONCE_THIS_CPU()
From: Marco Elver <elver@google.com>
To: elver@google.com
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Alexander Potapenko <glider@google.com>, 
	Boqun Feng <boqun.feng@gmail.com>, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
	Dmitry Vyukov <dvyukov@google.com>, linux-arch@vger.kernel.org, 
	Kunwu Chan <kunwu.chan@gmail.com>, Thomas Gleixner <tglx@kernel.org>
Content-Type: text/plain; charset="UTF-8"

READ_ONCE_THIS_CPU() and WRITE_ONCE_THIS_CPU() identify accesses to
per-CPU data that are intended to race only with other contexts on the
same CPU. So far they are plain READ_ONCE() and WRITE_ONCE(): no marked
accesses involving them are reported, incl. from other CPUs.

Make the new accessors assert exclusivity but ignore same-CPU accesses:
READ_ONCE_THIS_CPU() asserts no concurrent writers,
WRITE_ONCE_THIS_CPU() asserts no concurrent accesses.

For KCSAN to ignore racing accesses from other contexts on the same CPU,
introduce KCSAN_ACCESS_THIS_CPU, which makes KCSAN keep interrupts
disabled while the watchpoint is set up. A value change without a racing
access is not reported for these accesses, since it may be due to a
permitted write from an NMI on the same CPU.

With that, any racing accesses (incl. marked ones) from other CPUs
involving READ_ONCE_THIS_CPU() and WRITE_ONCE_THIS_CPU() will be
reported as "KCSAN: assert: race ...".

Suggested-by: Kunwu Chan <kunwu.chan@gmail.com>
Tested-by: Kunwu Chan <kunwu.chan@gmail.com>
Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com>
Cc: Thomas Gleixner <tglx@kernel.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Marco Elver <elver@google.com>
---
v2:
* Avoid unknown-origin reports from NMI (Kunwu).
* Fix flaky test (remote_read) (Kunwu).
---
 include/asm-generic/rwonce.h | 22 ++++++--
 include/linux/kcsan-checks.h |  1 +
 kernel/kcsan/core.c          | 10 +++-
 kernel/kcsan/kcsan_test.c    | 99 ++++++++++++++++++++++++++++++++++++
 4 files changed, 126 insertions(+), 6 deletions(-)

diff --git a/include/asm-generic/rwonce.h b/include/asm-generic/rwonce.h
index 3dc65a3310fb..e2d563096738 100644
--- a/include/asm-generic/rwonce.h
+++ b/include/asm-generic/rwonce.h
@@ -66,11 +66,25 @@ do {									\
  * which are intended to race only with accesses from other execution
  * contexts on the same CPU, e.g. task and interrupt context.
  *
- * For now, these are simple wrappers around READ_ONCE() and
- * WRITE_ONCE().
+ * With KCSAN, concurrent writes (for READ_ONCE_THIS_CPU()) or any concurrent
+ * accesses (for WRITE_ONCE_THIS_CPU()) from other CPUs are reported.
  */
-#define READ_ONCE_THIS_CPU(x)		READ_ONCE(x)
-#define WRITE_ONCE_THIS_CPU(x, val)	WRITE_ONCE(x, val)
+#define READ_ONCE_THIS_CPU(x)						\
+({									\
+	auto __tc_p = &(x);						\
+	kcsan_check_access(__tc_p, sizeof(*__tc_p),			\
+			   KCSAN_ACCESS_ASSERT | KCSAN_ACCESS_THIS_CPU);\
+	READ_ONCE(*__tc_p);						\
+})
+
+#define WRITE_ONCE_THIS_CPU(x, val)					\
+do {									\
+	auto __tc_p = &(x);						\
+	kcsan_check_access(__tc_p, sizeof(*__tc_p),			\
+			   KCSAN_ACCESS_ASSERT | KCSAN_ACCESS_WRITE |	\
+			   KCSAN_ACCESS_THIS_CPU);			\
+	WRITE_ONCE(*__tc_p, val);					\
+} while (0)
 
 static __no_sanitize_or_inline
 unsigned long __read_once_word_nocheck(const void *addr)
diff --git a/include/linux/kcsan-checks.h b/include/linux/kcsan-checks.h
index e135dacaa90f..afe50fe351fa 100644
--- a/include/linux/kcsan-checks.h
+++ b/include/linux/kcsan-checks.h
@@ -20,6 +20,7 @@
 /* The following are special, and never due to compiler instrumentation. */
 #define KCSAN_ACCESS_ASSERT	(1 << 3) /* Access is an assertion. */
 #define KCSAN_ACCESS_SCOPED	(1 << 4) /* Access is a scoped access. */
+#define KCSAN_ACCESS_THIS_CPU	(1 << 5) /* Ignore races from same-CPU accesses. */
 
 /*
  * __kcsan_*: Always calls into the runtime when KCSAN is enabled. This may be used
diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
index 26755add7cdb..b3e0c2627712 100644
--- a/kernel/kcsan/core.c
+++ b/kernel/kcsan/core.c
@@ -567,9 +567,13 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type, unsigned
 	 *	1. Races of the reordered access with interrupts. To avoid, if
 	 *	   the current access is reorder_access, disable interrupts.
 	 *	2. Avoid races of scoped accesses from nested interrupts (below).
+	 *
+	 * Similarly, KCSAN_ACCESS_THIS_CPU accesses may only race with
+	 * interrupts on the same CPU: disable interrupts, so that only races
+	 * with other CPUs are detected.
 	 */
 	is_reorder_access = find_reorder_access(ctx, ptr, size, type, ip);
-	if (is_reorder_access)
+	if (is_reorder_access || (type & KCSAN_ACCESS_THIS_CPU))
 		interrupt_watcher = false;
 	/*
 	 * Avoid races of scoped accesses from nested interrupts (or scheduler).
@@ -685,7 +689,9 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type, unsigned
 		kcsan_report_known_origin(ptr, size, type, ip,
 					  value_change, watchpoint - watchpoints,
 					  old, new, access_mask);
-	} else if (value_change == KCSAN_VALUE_CHANGE_TRUE) {
+	} else if (value_change == KCSAN_VALUE_CHANGE_TRUE &&
+		   /* May be due to a permitted write from NMI on this CPU. */
+		   !(type & KCSAN_ACCESS_THIS_CPU)) {
 		/* Inferring a race, since the value should not have changed. */
 
 		atomic_long_inc(&kcsan_counters[KCSAN_COUNTER_RACES_UNKNOWN_ORIGIN]);
diff --git a/kernel/kcsan/kcsan_test.c b/kernel/kcsan/kcsan_test.c
index 1c8853f14dae..1edf9f3539d4 100644
--- a/kernel/kcsan/kcsan_test.c
+++ b/kernel/kcsan/kcsan_test.c
@@ -22,6 +22,7 @@
 #include <linux/kcsan-checks.h>
 #include <linux/kernel.h>
 #include <linux/mutex.h>
+#include <linux/percpu.h>
 #include <linux/sched.h>
 #include <linux/seqlock.h>
 #include <linux/spinlock.h>
@@ -337,6 +338,7 @@ static struct {
 	long val[8];
 } test_struct;
 static long __data_racy test_data_racy;
+static DEFINE_PER_CPU(long, test_pcpu_var);
 static DEFINE_SEQLOCK(test_seqlock);
 static DEFINE_SPINLOCK(test_spinlock);
 static DEFINE_MUTEX(test_mutex);
@@ -403,6 +405,42 @@ static noinline void test_kernel_assert_access(void)
 	ASSERT_EXCLUSIVE_ACCESS(test_var);
 }
 
+static noinline void test_kernel_read_this_cpu(void)
+{
+	sink_value(READ_ONCE_THIS_CPU(test_var));
+}
+
+static noinline void test_kernel_write_this_cpu(void)
+{
+	preempt_disable();
+	WRITE_ONCE_THIS_CPU(*this_cpu_ptr(&test_pcpu_var), 42);
+	preempt_enable();
+}
+
+/* Plain reads of other CPUs' instances. */
+static noinline void test_kernel_read_remote_cpus(void)
+{
+	int this_cpu = get_cpu();
+	int cpu;
+
+	for_each_online_cpu(cpu) {
+		if (cpu != this_cpu)
+			sink_value(per_cpu(test_pcpu_var, cpu));
+	}
+	put_cpu();
+}
+
+static noinline void test_kernel_reset_this_cpu(void)
+{
+	long *p;
+
+	preempt_disable();
+	p = this_cpu_ptr(&test_pcpu_var);
+	if (READ_ONCE_THIS_CPU(*p))
+		WRITE_ONCE_THIS_CPU(*p, 0);
+	preempt_enable();
+}
+
 #define TEST_CHANGE_BITS 0xff00ff00
 
 static noinline void test_kernel_change_bits(void)
@@ -1223,6 +1261,64 @@ static void test_assert_exclusive_access_scoped(struct kunit *test)
 	KUNIT_EXPECT_FALSE(test, match_expect_inscope);
 }
 
+/* Test that remote writes racing with READ_ONCE_THIS_CPU() are reported. */
+__no_kcsan
+static void test_this_cpu_remote_write(struct kunit *test)
+{
+	struct expect_report expect = {
+		.access = {
+			{ test_kernel_read_this_cpu, &test_var, sizeof(test_var), KCSAN_ACCESS_ASSERT },
+			{ test_kernel_write_atomic, &test_var, sizeof(test_var), KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ATOMIC },
+		},
+	};
+	bool match_expect = false;
+
+	KCSAN_TEST_REQUIRES(test, !IS_ENABLED(CONFIG_KCSAN_IGNORE_ATOMICS));
+
+	begin_test_checks(test_kernel_read_this_cpu, test_kernel_write_atomic);
+	do {
+		match_expect = report_matches(&expect);
+	} while (!end_test_checks(match_expect));
+	KUNIT_EXPECT_TRUE(test, match_expect);
+}
+
+/* Test that remote reads racing with WRITE_ONCE_THIS_CPU() are reported. */
+__no_kcsan
+static void test_this_cpu_remote_read(struct kunit *test)
+{
+	struct expect_report expect = {
+		.access = {
+			/* Address unchecked: may be any CPU's instance. */
+			{ test_kernel_write_this_cpu, NULL, 0, KCSAN_ACCESS_ASSERT | KCSAN_ACCESS_WRITE },
+			{ test_kernel_read_remote_cpus, NULL, 0, 0 },
+		},
+	};
+	bool match_expect = false;
+
+	begin_test_checks(test_kernel_write_this_cpu, test_kernel_read_remote_cpus);
+	do {
+		match_expect = report_matches(&expect);
+	} while (!end_test_checks(match_expect));
+	KUNIT_EXPECT_TRUE(test, match_expect);
+}
+
+/*
+ * Test that races between task and interrupt on the same CPU's instance are not
+ * reported; the test threads' timers access the same per-CPU instance as the
+ * interrupted thread. Only meaningful with CONFIG_KCSAN_INTERRUPT_WATCHER=y.
+ */
+__no_kcsan
+static void test_this_cpu_local_noreport(struct kunit *test)
+{
+	bool match_never = false;
+
+	begin_test_checks(test_kernel_write_this_cpu, test_kernel_reset_this_cpu);
+	do {
+		match_never = report_available();
+	} while (!end_test_checks(match_never));
+	KUNIT_EXPECT_FALSE(test, match_never);
+}
+
 /*
  * jiffies is special (declared to be volatile) and its accesses are typically
  * not marked; this test ensures that the compiler nor KCSAN gets confused about
@@ -1485,6 +1581,9 @@ static struct kunit_case kcsan_test_cases[] = {
 	KCSAN_KUNIT_CASE(test_assert_exclusive_bits_nochange),
 	KCSAN_KUNIT_CASE(test_assert_exclusive_writer_scoped),
 	KCSAN_KUNIT_CASE(test_assert_exclusive_access_scoped),
+	KCSAN_KUNIT_CASE(test_this_cpu_remote_write),
+	KCSAN_KUNIT_CASE(test_this_cpu_remote_read),
+	KCSAN_KUNIT_CASE(test_this_cpu_local_noreport),
 	KCSAN_KUNIT_CASE(test_jiffies_noreport),
 	KCSAN_KUNIT_CASE(test_seqlock_noreport),
 	KCSAN_KUNIT_CASE(test_atomic_builtins),
-- 
2.56.1.839.g22a8290db9-goog


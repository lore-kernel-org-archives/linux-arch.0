Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795441914;
	b=rcaClmnAtzeu7JodPKwjCSXE7TxlVoaeKHK4JO+tz+MO39ylc/ykkmw8YoLiOh1dPHC4
	 dv84y9FVV9UudqKRTcCxheNvNbiD1pjKnVAwcDDwqweV+f0EwcqDwZ2NDdLKXdYXcftCn
	 wEWpr6CgC7oM/fd53xOZq7+uc0UxxvZXOZ/8QWVoSJWmIOzlpSOuCn9AwP82VUtBa6+Pf
	 3VtJKOS/BYe73l2Xl06lQmXMZqcUjpfZnWesFQ/uhiGWCxgxC7+U5VSp5a0t1b25YksMz
	 hxDyAC2oJCCv4Yst8Rstj+eQFiHIS0y/YpdZodlTHJX32E1pe8XvzR5WUzJ3NTkpjzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795441914;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=eaI3BS218z8G1KCco511xk4WZpDnLwGg82cQaYzcRu0=;
	b=u2O+8q+YRgTS9nu+k4RytEs/cYaf6u7GcEWNUt8EacjjuwIT1dzpZPNWPOv71sDCsliG
	 7P5fnh2UWbbctUi8LqBPXMXX6V/34hqgC9Yr6e5zGbIpqKOP1TBGU1nxWBoJOF4AwkWXR
	 ruYeQ4ZUcMPBLT0ZwhKoDwKwZ3o6M9w8HDTwf2WJ9LfoJDvJpskccCGE4+tIlR386dzVF
	 XANW3/BxSNyMuYJJQVSpVYjsjJPX6A8f7ZB9mNkCKd+pCtx4ZYSFxQHpLz7+5jtdXmrZj
	 KetrTFQ8pFkDnimn2cgos7fk/oXAEqxTJZDpsQAH6P0h+Jnf7HUQ5QT7+iU1bRMrIhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--elver.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=MDoPuilQ;
	arc=none smtp.remote-ip=209.85.128.71
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88094606A31A
	for <linux-arch@vger.kernel.org>; Mon, 23 Nov 2026 13:51:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88094606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=MDoPuilQ
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4a359c7f47bso27904475e9.2
        for <linux-arch@vger.kernel.org>; Mon, 23 Nov 2026 05:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795441912; x=1796046712; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eaI3BS218z8G1KCco511xk4WZpDnLwGg82cQaYzcRu0=;
        b=MDoPuilQE6oM/OjXxQd446ieop5BCMifGVfmXlrdpEqhrS1Vzx89fWYZkH8z2lt0ux
         h2Gh+HjrvFOO5ehWe1l/T2lkamlGTZk9ACyuoWMsyrzLTIKYGdegsBCSfLj/B2d0PPs4
         r8iDfSP0v+zMUin9AiJadqzXnkBHvI1QR7kGJInB0+J7ieK7KtQgiZBHsdJXro2ul/ur
         lyO7hmElQFY3vzGw0jMmXAYsz1/QOj0aTwnotAfpoK9Gzkm+xLafdXDJ/nyKMyfotHAd
         OWzT8DmlaDxb7h/rSE3cCUUZC26zV5SHTS+EsVIt6kabsPmmArLSnoTQvvrIjt9rqUHi
         Y1cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795441912; x=1796046712;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eaI3BS218z8G1KCco511xk4WZpDnLwGg82cQaYzcRu0=;
        b=x+2Nw194LFZX8zoc1qPbTB3fKfhG6NuedgbHeZL/LxP0m7zZyHkyuyummGzjig6DW2
         phh87/5UqMfUzGdgc0H/YaG0PEXRbZCx07YVsxlNppM5cn+/75A7nF7jG+017ntv/oId
         NeOvkZkW1vacNU59Dsp2cY1e2iFKv0xcDSiB9a6HlcI0I6EZetMzkY+hhn2cKuNX4R6y
         c7M5aT3g4eaZ8vb18hkrghRsOIu+HsBWp/k9AFjnW/h0/mqasNPbQ2xZiXNrdVxrxP7r
         B7bvT2VT7SkOCETliBxaGkVrOwY83JEvTAaLWbHT2vxfupHzdYhGOGKG83vKK8998u36
         EHcQ==
X-Forwarded-Encrypted: i=1; AL+hErFzjJuZN7b3k4RW+eNxbj5GIWnaSedXTbbaOeIYrGvvaTbegSiGqfZDsrizvl6Ofh1uzqSbCSWnhdvG@vger.kernel.org
X-Gm-Message-State: APuU4Z8xw3peBIF82Njm/MA1fzN/YFZd2hkGOzOxQL5e1AQvleFpsOh5
	SOAO//CwlFxHuCxV1dNl9QCXToIJ+YsPYzdk2Jk/dTeLKyGMYtsWCRx/6gR66O0kEKnMBC9d4QN
	xhg==
X-Received: from wmcz23.prod.google.com ([2002:a05:600c:c297:b0:4a1:e780:89af])
 (user=elver job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:6749:b0:4a2:1867:10e8
 with SMTP id 5b1f17b1804b1-4bb8881a294mr238282025e9.25.1795441910897; Mon, 23
 Nov 2026 05:51:50 -0800 (PST)
Date: Mon, 23 Nov 2026 13:51:43 +0000
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261123135148.1146372-1-elver@google.com>
Subject: [PATCH] kcsan: Detect cross-CPU races on {READ,WRITE}_ONCE_THIS_CPU()
From: Marco Elver <elver@google.com>
To: elver@google.com
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Alexander Potapenko <glider@google.com>, 
	Boqun Feng <boqun.feng@gmail.com>, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
	Dmitry Vyukov <dvyukov@google.com>, linux-arch@vger.kernel.org, 
	KunWu Chan <kunwu.chan@gmail.com>, Thomas Gleixner <tglx@kernel.org>
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
disabled while the watchpoint is set up.

With that, any racing accesses (incl. marked ones) from other CPUs
involving READ_ONCE_THIS_CPU() and WRITE_ONCE_THIS_CPU() will be
reported as "KCSAN: assert: race ...".

Suggested-by: KunWu Chan <kunwu.chan@gmail.com>
Cc: Thomas Gleixner <tglx@kernel.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Marco Elver <elver@google.com>
---
 include/asm-generic/rwonce.h | 22 +++++++--
 include/linux/kcsan-checks.h |  1 +
 kernel/kcsan/core.c          |  6 ++-
 kernel/kcsan/kcsan_test.c    | 90 ++++++++++++++++++++++++++++++++++++
 4 files changed, 114 insertions(+), 5 deletions(-)

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
index 26755add7cdb..51340bf1d4a3 100644
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
diff --git a/kernel/kcsan/kcsan_test.c b/kernel/kcsan/kcsan_test.c
index 1c8853f14dae..3e9689492abe 100644
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
@@ -403,6 +405,34 @@ static noinline void test_kernel_assert_access(void)
 	ASSERT_EXCLUSIVE_ACCESS(test_var);
 }
 
+static noinline void test_kernel_read_this_cpu(void)
+{
+	sink_value(READ_ONCE_THIS_CPU(test_var));
+}
+
+static noinline void test_kernel_write_this_cpu(void)
+{
+	WRITE_ONCE_THIS_CPU(test_var, 42);
+}
+
+static noinline void test_kernel_write_this_cpu_local(void)
+{
+	preempt_disable();
+	WRITE_ONCE_THIS_CPU(*this_cpu_ptr(&test_pcpu_var), 1);
+	preempt_enable();
+}
+
+static noinline void test_kernel_reset_this_cpu_local(void)
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
@@ -1223,6 +1253,63 @@ static void test_assert_exclusive_access_scoped(struct kunit *test)
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
+			{ test_kernel_write_this_cpu, &test_var, sizeof(test_var), KCSAN_ACCESS_ASSERT | KCSAN_ACCESS_WRITE },
+			{ test_kernel_read, &test_var, sizeof(test_var), 0 },
+		},
+	};
+	bool match_expect = false;
+
+	begin_test_checks(test_kernel_write_this_cpu, test_kernel_read);
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
+	begin_test_checks(test_kernel_write_this_cpu_local, test_kernel_reset_this_cpu_local);
+	do {
+		match_never = report_available();
+	} while (!end_test_checks(match_never));
+	KUNIT_EXPECT_FALSE(test, match_never);
+}
+
 /*
  * jiffies is special (declared to be volatile) and its accesses are typically
  * not marked; this test ensures that the compiler nor KCSAN gets confused about
@@ -1485,6 +1572,9 @@ static struct kunit_case kcsan_test_cases[] = {
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
2.56.1.750.gf70dc682cf-goog


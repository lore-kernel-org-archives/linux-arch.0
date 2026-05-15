Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E369741325D
	for <linux-arch@vger.kernel.org>; Fri, 15 May 2026 08:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778835212; cv=none; b=rFxx8VLNDZgaCNLdHXLuRohC4J/JApZwK3H7X44AAzyFlqeemjXqxjwMbsRAXoV+O5oUkUr+KsGWKwXIUQ45LaypBF4gKpfnOSfIs3Jk/9mWjJoSCLJvzTB7KhupjP/Z7ZHV3s09jS6danUE2Cs3TMiJsivcD/4fu6WiiDKpcRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778835212; c=relaxed/simple;
	bh=5Kc+vq+mTVL0V1Y9D97lCZI1fYLcYqouY+DVWKFQlJA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JAy8EWyAJElWFmyEXVnCKSnCKCZOgJbmzcNzhG5rp0mYx5OwO8dMxJLpdxsFLimbPzwnWk6s2DxFSMdqZ1Vush7kZA6WcxCdVvXW/eR2MKv5dzrV3v6qrNyNhFs6A3gj380ldhjHF/iM3mCzKVP2UvlCQ8na+M4LDbFu9aBS1p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ibgp5xl1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ibgp5xl1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778835208;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vocfv8X6sC3JpCoVoIUoxZpmc+3EyjWnx/brcltJKZA=;
	b=ibgp5xl1Ke5JUSKo4UfBleBbazy36P25+HZTRgGgsWAzNDCWU/t3BxC8HAfMr1/GcTFXyB
	2aHmeHXx/J8vtolTET5Lh0nOHAUsaIlUiTVc6jNuQSXdz4rDksK/Mo6yN0T998pSGh8e/0
	7yWMma5P4MaUdHLvBcJ9pATLnwekUQ0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-628-4a9suRC3M0eLdSSn_n1e9w-1; Fri,
 15 May 2026 04:53:19 -0400
X-MC-Unique: 4a9suRC3M0eLdSSn_n1e9w-1
X-Mimecast-MFC-AGG-ID: 4a9suRC3M0eLdSSn_n1e9w_1778835196
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3AB0918002C8;
	Fri, 15 May 2026 08:53:15 +0000 (UTC)
Received: from [192.168.1.153] (headnet01.pony-001.prod.iad2.dc.redhat.com [10.2.32.101])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9967A1955F2D;
	Fri, 15 May 2026 08:53:07 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
Date: Fri, 15 May 2026 10:52:50 +0200
Subject: [PATCH v12 1/4] bug/kunit: Core support for suppressing warning
 backtraces
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-kunit_add_support-v12-1-a216dc228be8@redhat.com>
References: <20260515-kunit_add_support-v12-0-a216dc228be8@redhat.com>
In-Reply-To: <20260515-kunit_add_support-v12-0-a216dc228be8@redhat.com>
To: Arnd Bergmann <arnd@arndb.de>, 
 Brendan Higgins <brendan.higgins@linux.dev>, David Gow <david@davidgow.net>, 
 Rae Moar <raemoar63@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 dri-devel@lists.freedesktop.org, workflows@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-doc@vger.kernel.org, 
 peterz@infradead.org, Alessandro Carminati <acarmina@redhat.com>, 
 Guenter Roeck <linux@roeck-us.net>, Kees Cook <kees@kernel.org>, 
 Albert Esteve <aesteve@redhat.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778835177; l=17209;
 i=aesteve@redhat.com; s=20260303; h=from:subject:message-id;
 bh=W/1CY6niuMYarxTFCQH1sQK3vRBqEnqe7pJ2GOgXriI=;
 b=f+k7BO6igZbE4eOGvSVFZQqp5GJ7cVd+26dCHMsiRW7Kf2Qkt/PnOvg4BeeJjPFjgo1XFd/UR
 xPrDjx/5mehDL7dhM8O1B9vykCpgM7hf9JLnneiMP57rg7zCVTkmEo9
X-Developer-Key: i=aesteve@redhat.com; a=ed25519;
 pk=YSFz6sOHd2L45+Fr8DIvHTi6lSIjhLZ5T+rkxspJt1s=
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

From: Alessandro Carminati <acarmina@redhat.com>

Some unit tests intentionally trigger warning backtraces by passing bad
parameters to kernel API functions. Such unit tests typically check the
return value from such calls, not the existence of the warning backtrace.

Such intentionally generated warning backtraces are neither desirable
nor useful for a number of reasons:
- They can result in overlooked real problems.
- A warning that suddenly starts to show up in unit tests needs to be
  investigated and has to be marked to be ignored, for example by
  adjusting filter scripts. Such filters are ad hoc because there is
  no real standard format for warnings. On top of that, such filter
  scripts would require constant maintenance.

Solve the problem by providing a means to suppress warning backtraces
originating from the current kthread while executing test code. Since
each KUnit test runs in its own kthread, this effectively scopes
suppression to the test that enabled it. Limit changes to generic code
to the absolute minimum.

Implementation details:
Suppression is integrated into the existing KUnit hooks infrastructure
in test-bug.h, reusing the kunit_running static branch for zero
overhead when no tests are running.

Suppression is checked at three points in the warning path:
- In warn_slowpath_fmt(), the check runs before any output, fully
  suppressing both message and backtrace. This covers architectures
  without __WARN_FLAGS.
- In __warn_printk(), the check suppresses the warning message text.
  This covers architectures that define __WARN_FLAGS but not their own
  __WARN_printf (arm64, loongarch, parisc, powerpc, riscv, sh), where
  the message is printed before the trap enters __report_bug().
- In __report_bug(), the check runs before __warn() is called,
  suppressing the backtrace and stack dump.

To avoid double-counting on architectures where both __warn_printk()
and __report_bug() run for the same warning, kunit_is_suppressed_warning()
takes a bool parameter: true to increment the suppression counter
(used in warn_slowpath_fmt and __report_bug), false to check only
(used in __warn_printk).

The suppression state is dynamically allocated via kzalloc() and its
lifetime is managed via kunit_add_action(). On cleanup, the node is
removed with list_del_rcu() and the object is freed asynchronously via
call_rcu(), ensuring that any concurrent RCU reader that obtained a
pointer to the handle before removal can finish safely. Writer-side
access to the global suppression list is serialized with a spinlock;
readers use RCU.

Two API forms are provided:
- kunit_warning_suppress(test) { ... }: scoped, uses __cleanup for
  automatic teardown on scope exit, kunit_add_action() as safety net
  for abnormal exits (e.g. kthread_exit from failed assertions).
  Suppression handle is only accessible inside the block.
- kunit_start/end_suppress_warning(test): direct functions returning
  an explicit handle, for retaining the handle within the test,
  or for cross-function usage.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Alessandro Carminati <acarmina@redhat.com>
Reviewed-by: Kees Cook <kees@kernel.org>
Reviewed-by: David Gow <david@davidgow.net>
Signed-off-by: Albert Esteve <aesteve@redhat.com>
---
 include/kunit/test-bug.h |  26 ++++++++++
 include/kunit/test.h     |  98 +++++++++++++++++++++++++++++++++++
 kernel/panic.c           |  11 ++++
 lib/bug.c                |  12 ++++-
 lib/kunit/Makefile       |   3 +-
 lib/kunit/bug.c          | 131 +++++++++++++++++++++++++++++++++++++++++++++++
 lib/kunit/hooks-impl.h   |   2 +
 7 files changed, 280 insertions(+), 3 deletions(-)

diff --git a/include/kunit/test-bug.h b/include/kunit/test-bug.h
index 47aa8f21ccce8..99869029fc686 100644
--- a/include/kunit/test-bug.h
+++ b/include/kunit/test-bug.h
@@ -10,6 +10,7 @@
 #define _KUNIT_TEST_BUG_H
 
 #include <linux/stddef.h> /* for NULL */
+#include <linux/types.h>  /* for bool */
 
 #if IS_ENABLED(CONFIG_KUNIT)
 
@@ -23,6 +24,7 @@ DECLARE_STATIC_KEY_FALSE(kunit_running);
 extern struct kunit_hooks_table {
 	__printf(3, 4) void (*fail_current_test)(const char*, int, const char*, ...);
 	void *(*get_static_stub_address)(struct kunit *test, void *real_fn_addr);
+	bool (*is_suppressed_warning)(bool count);
 } kunit_hooks;
 
 /**
@@ -60,9 +62,33 @@ static inline struct kunit *kunit_get_current_test(void)
 		}								\
 	} while (0)
 
+/**
+ * kunit_is_suppressed_warning() - Check if warnings are being suppressed
+ *                                 by the current KUnit test.
+ * @count: if true, increment the suppression counter on match.
+ *
+ * Returns true if the current task has active warning suppression.
+ * Uses the kunit_running static branch for zero overhead when no tests run.
+ *
+ * A single WARN*() may traverse multiple call sites in the warning path
+ * (e.g., __warn_printk() and __report_bug()). Pass @count = true at the
+ * primary suppression point to count each warning exactly once, and
+ * @count = false at secondary points to suppress output without
+ * inflating the count.
+ */
+static inline bool kunit_is_suppressed_warning(bool count)
+{
+	if (!static_branch_unlikely(&kunit_running))
+		return false;
+
+	return kunit_hooks.is_suppressed_warning &&
+	       kunit_hooks.is_suppressed_warning(count);
+}
+
 #else
 
 static inline struct kunit *kunit_get_current_test(void) { return NULL; }
+static inline bool kunit_is_suppressed_warning(bool count) { return false; }
 
 #define kunit_fail_current_test(fmt, ...) do {} while (0)
 
diff --git a/include/kunit/test.h b/include/kunit/test.h
index 9cd1594ab697d..be71612f61655 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -1795,4 +1795,102 @@ do {									       \
 // include resource.h themselves if they need it.
 #include <kunit/resource.h>
 
+/*
+ * Warning backtrace suppression API.
+ *
+ * Suppresses WARN*() backtraces on the current task while active. Two forms
+ * are provided:
+ *
+ * - Scoped: kunit_warning_suppress(test) { ... }
+ *   Suppression is active for the duration of the block. On normal exit,
+ *   the for-loop increment deactivates suppression. On early exit (break,
+ *   return, goto), the __cleanup attribute fires. On kthread_exit() (e.g.,
+ *   a failed KUnit assertion), kunit_add_action() cleans up at test
+ *   teardown. The suppression handle is only accessible inside the block,
+ *   so warning counts must be checked before the block exits.
+ *
+ * - Direct: kunit_start_suppress_warning() / kunit_end_suppress_warning()
+ *   The underlying functions, returning an explicit handle pointer. Use
+ *   when the handle needs to be retained (e.g., for post-suppression
+ *   count checks) or passed across helper functions.
+ */
+struct kunit_suppressed_warning;
+
+struct kunit_suppressed_warning *
+kunit_start_suppress_warning(struct kunit *test);
+void kunit_end_suppress_warning(struct kunit *test,
+				struct kunit_suppressed_warning *w);
+int kunit_suppressed_warning_count(struct kunit_suppressed_warning *w);
+void __kunit_suppress_auto_cleanup(struct kunit_suppressed_warning **wp);
+bool kunit_has_active_suppress_warning(void);
+
+/**
+ * kunit_warning_suppress() - Suppress WARN*() backtraces for the duration
+ *                            of a block.
+ * @test: The test context object.
+ *
+ * Scoped form of the suppression API. Suppression starts when the block is
+ * entered and ends automatically when the block exits through any path. See
+ * the section comment above for the cleanup guarantees on each exit path.
+ * Fails the test if suppression is already active; nesting is not supported.
+ *
+ * The warning count can be checked inside the block via
+ * KUNIT_EXPECT_SUPPRESSED_WARNING_COUNT(). The handle is not accessible
+ * after the block exits.
+ *
+ * Example::
+ *
+ *   kunit_warning_suppress(test) {
+ *       trigger_warning();
+ *       KUNIT_EXPECT_SUPPRESSED_WARNING_COUNT(test, 1);
+ *   }
+ */
+#define kunit_warning_suppress(test)					\
+	for (struct kunit_suppressed_warning *__kunit_suppress		\
+	     __cleanup(__kunit_suppress_auto_cleanup) =			\
+	     kunit_start_suppress_warning(test);			\
+	     __kunit_suppress;						\
+	     kunit_end_suppress_warning(test, __kunit_suppress),	\
+	     __kunit_suppress = NULL)
+
+/**
+ * KUNIT_SUPPRESSED_WARNING_COUNT() - Returns the suppressed warning count.
+ *
+ * Returns the number of WARN*() calls suppressed since the current
+ * suppression block started, or 0 if the handle is NULL. Usable inside a
+ * kunit_warning_suppress() block.
+ */
+#define KUNIT_SUPPRESSED_WARNING_COUNT() \
+	kunit_suppressed_warning_count(__kunit_suppress)
+
+/**
+ * KUNIT_EXPECT_SUPPRESSED_WARNING_COUNT() - Sets an expectation that the
+ *                                           suppressed warning count equals
+ *                                           @expected.
+ * @test: The test context object.
+ * @expected: an expression that evaluates to the expected warning count.
+ *
+ * Sets an expectation that the number of suppressed WARN*() calls equals
+ * @expected. This is semantically equivalent to
+ * KUNIT_EXPECT_EQ(@test, KUNIT_SUPPRESSED_WARNING_COUNT(), @expected).
+ * See KUNIT_EXPECT_EQ() for more information.
+ */
+#define KUNIT_EXPECT_SUPPRESSED_WARNING_COUNT(test, expected) \
+	KUNIT_EXPECT_EQ(test, KUNIT_SUPPRESSED_WARNING_COUNT(), expected)
+
+/**
+ * KUNIT_ASSERT_SUPPRESSED_WARNING_COUNT() - Sets an assertion that the
+ *                                           suppressed warning count equals
+ *                                           @expected.
+ * @test: The test context object.
+ * @expected: an expression that evaluates to the expected warning count.
+ *
+ * Sets an assertion that the number of suppressed WARN*() calls equals
+ * @expected. This is the same as KUNIT_EXPECT_SUPPRESSED_WARNING_COUNT(),
+ * except it causes an assertion failure (see KUNIT_ASSERT_TRUE()) when the
+ * assertion is not met.
+ */
+#define KUNIT_ASSERT_SUPPRESSED_WARNING_COUNT(test, expected) \
+	KUNIT_ASSERT_EQ(test, KUNIT_SUPPRESSED_WARNING_COUNT(), expected)
+
 #endif /* _KUNIT_TEST_H */
diff --git a/kernel/panic.c b/kernel/panic.c
index 20feada5319d4..213725b612aa1 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -39,6 +39,7 @@
 #include <linux/sys_info.h>
 #include <trace/events/error_report.h>
 #include <asm/sections.h>
+#include <kunit/test-bug.h>
 
 #define PANIC_TIMER_STEP 100
 #define PANIC_BLINK_SPD 18
@@ -1124,6 +1125,11 @@ void warn_slowpath_fmt(const char *file, int line, unsigned taint,
 	bool rcu = warn_rcu_enter();
 	struct warn_args args;
 
+	if (kunit_is_suppressed_warning(true)) {
+		warn_rcu_exit(rcu);
+		return;
+	}
+
 	pr_warn(CUT_HERE);
 
 	if (!fmt) {
@@ -1146,6 +1152,11 @@ void __warn_printk(const char *fmt, ...)
 	bool rcu = warn_rcu_enter();
 	va_list args;
 
+	if (kunit_is_suppressed_warning(false)) {
+		warn_rcu_exit(rcu);
+		return;
+	}
+
 	pr_warn(CUT_HERE);
 
 	va_start(args, fmt);
diff --git a/lib/bug.c b/lib/bug.c
index 224f4cfa4aa31..874cb4ae4d047 100644
--- a/lib/bug.c
+++ b/lib/bug.c
@@ -48,6 +48,7 @@
 #include <linux/rculist.h>
 #include <linux/ftrace.h>
 #include <linux/context_tracking.h>
+#include <kunit/test-bug.h>
 
 extern struct bug_entry __start___bug_table[], __stop___bug_table[];
 
@@ -209,8 +210,6 @@ static enum bug_trap_type __report_bug(struct bug_entry *bug, unsigned long buga
 			return BUG_TRAP_TYPE_NONE;
 	}
 
-	disable_trace_on_warning();
-
 	bug_get_file_line(bug, &file, &line);
 	fmt = bug_get_format(bug);
 
@@ -220,6 +219,15 @@ static enum bug_trap_type __report_bug(struct bug_entry *bug, unsigned long buga
 	no_cut   = bug->flags & BUGFLAG_NO_CUT_HERE;
 	has_args = bug->flags & BUGFLAG_ARGS;
 
+	/*
+	 * Before the once logic so suppressed warnings do not consume
+	 * the single-fire budget of WARN_ON_ONCE().
+	 */
+	if (warning && kunit_is_suppressed_warning(true))
+		return BUG_TRAP_TYPE_WARN;
+
+	disable_trace_on_warning();
+
 	if (warning && once) {
 		if (done)
 			return BUG_TRAP_TYPE_WARN;
diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
index 656f1fa35abcc..4592f9d0aa8dd 100644
--- a/lib/kunit/Makefile
+++ b/lib/kunit/Makefile
@@ -10,7 +10,8 @@ kunit-objs +=				test.o \
 					executor.o \
 					attributes.o \
 					device.o \
-					platform.o
+					platform.o \
+					bug.o
 
 ifeq ($(CONFIG_KUNIT_DEBUGFS),y)
 kunit-objs +=				debugfs.o
diff --git a/lib/kunit/bug.c b/lib/kunit/bug.c
new file mode 100644
index 0000000000000..8a5725aebcaa4
--- /dev/null
+++ b/lib/kunit/bug.c
@@ -0,0 +1,131 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit helpers for backtrace suppression
+ *
+ * Copyright (C) 2025 Alessandro Carminati <acarmina@redhat.com>
+ * Copyright (C) 2024 Guenter Roeck <linux@roeck-us.net>
+ */
+
+#include <kunit/resource.h>
+#include <linux/export.h>
+#include <linux/rculist.h>
+#include <linux/sched.h>
+#include <linux/sched/task.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+
+#include "hooks-impl.h"
+
+struct kunit_suppressed_warning {
+	struct list_head node;
+	struct rcu_head rcu;
+	struct task_struct *task;
+	struct kunit *test;
+	atomic_t counter;
+};
+
+static LIST_HEAD(suppressed_warnings);
+static DEFINE_SPINLOCK(suppressed_warnings_lock);
+
+static void kunit_suppress_warning_free(struct rcu_head *rcu)
+{
+	struct kunit_suppressed_warning *w =
+		container_of(rcu, struct kunit_suppressed_warning, rcu);
+
+	put_task_struct(w->task);
+	kfree(w);
+}
+
+static void kunit_suppress_warning_remove(struct kunit_suppressed_warning *w)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&suppressed_warnings_lock, flags);
+	list_del_rcu(&w->node);
+	spin_unlock_irqrestore(&suppressed_warnings_lock, flags);
+	call_rcu(&w->rcu, kunit_suppress_warning_free);
+}
+
+KUNIT_DEFINE_ACTION_WRAPPER(kunit_suppress_warning_cleanup,
+			    kunit_suppress_warning_remove,
+			    struct kunit_suppressed_warning *);
+
+bool kunit_has_active_suppress_warning(void)
+{
+	return __kunit_is_suppressed_warning_impl(false);
+}
+EXPORT_SYMBOL_GPL(kunit_has_active_suppress_warning);
+
+struct kunit_suppressed_warning *
+kunit_start_suppress_warning(struct kunit *test)
+{
+	struct kunit_suppressed_warning *w;
+	unsigned long flags;
+	int ret;
+
+	if (kunit_has_active_suppress_warning()) {
+		KUNIT_FAIL(test, "Another suppression block is already active");
+		return NULL;
+	}
+
+	w = kzalloc(sizeof(*w), GFP_KERNEL);
+	if (!w) {
+		KUNIT_FAIL(test, "Failed to allocate suppression handle.");
+		return NULL;
+	}
+
+	w->task = get_task_struct(current);
+	w->test = test;
+
+	spin_lock_irqsave(&suppressed_warnings_lock, flags);
+	list_add_rcu(&w->node, &suppressed_warnings);
+	spin_unlock_irqrestore(&suppressed_warnings_lock, flags);
+
+	ret = kunit_add_action_or_reset(test,
+					kunit_suppress_warning_cleanup, w);
+	if (ret) {
+		KUNIT_FAIL(test, "Failed to add suppression cleanup action.");
+		return NULL;
+	}
+
+	return w;
+}
+EXPORT_SYMBOL_GPL(kunit_start_suppress_warning);
+
+void kunit_end_suppress_warning(struct kunit *test,
+				struct kunit_suppressed_warning *w)
+{
+	if (!w)
+		return;
+	kunit_release_action(test, kunit_suppress_warning_cleanup, w);
+}
+EXPORT_SYMBOL_GPL(kunit_end_suppress_warning);
+
+void __kunit_suppress_auto_cleanup(struct kunit_suppressed_warning **wp)
+{
+	if (*wp)
+		kunit_end_suppress_warning((*wp)->test, *wp);
+}
+EXPORT_SYMBOL_GPL(__kunit_suppress_auto_cleanup);
+
+int kunit_suppressed_warning_count(struct kunit_suppressed_warning *w)
+{
+	return w ? atomic_read(&w->counter) : 0;
+}
+EXPORT_SYMBOL_GPL(kunit_suppressed_warning_count);
+
+bool __kunit_is_suppressed_warning_impl(bool count)
+{
+	struct kunit_suppressed_warning *w;
+
+	guard(rcu)();
+	list_for_each_entry_rcu(w, &suppressed_warnings, node) {
+		if (w->task == current) {
+			if (count)
+				atomic_inc(&w->counter);
+			return true;
+		}
+	}
+
+	return false;
+}
diff --git a/lib/kunit/hooks-impl.h b/lib/kunit/hooks-impl.h
index 4e71b2d0143ba..d8720f2616925 100644
--- a/lib/kunit/hooks-impl.h
+++ b/lib/kunit/hooks-impl.h
@@ -19,6 +19,7 @@ void __printf(3, 4) __kunit_fail_current_test_impl(const char *file,
 						   int line,
 						   const char *fmt, ...);
 void *__kunit_get_static_stub_address_impl(struct kunit *test, void *real_fn_addr);
+bool __kunit_is_suppressed_warning_impl(bool count);
 
 /* Code to set all of the function pointers. */
 static inline void kunit_install_hooks(void)
@@ -26,6 +27,7 @@ static inline void kunit_install_hooks(void)
 	/* Install the KUnit hook functions. */
 	kunit_hooks.fail_current_test = __kunit_fail_current_test_impl;
 	kunit_hooks.get_static_stub_address = __kunit_get_static_stub_address_impl;
+	kunit_hooks.is_suppressed_warning = __kunit_is_suppressed_warning_impl;
 }
 
 #endif /* _KUNIT_HOOKS_IMPL_H */

-- 
2.53.0

